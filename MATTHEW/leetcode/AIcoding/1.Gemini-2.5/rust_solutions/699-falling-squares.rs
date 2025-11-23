use std::collections::{BTreeSet, HashMap};

struct SegmentTree {
    tree: Vec<i32>,
    lazy: Vec<i32>,
    size: usize, // Number of leaves in the conceptual tree (corresponding to unique coordinates)
}

impl SegmentTree {
    fn new(num_coords: usize) -> Self {
        // A common heuristic for segment tree array size is 4 * num_leaves.
        let tree_size = 4 * num_coords; 
        SegmentTree {
            tree: vec![0; tree_size],
            lazy: vec![0; tree_size],
            size: num_coords,
        }
    }

    // Propagates lazy updates from current node to its children
    fn push_down(&mut self, node_idx: usize, start_idx: usize, end_idx: usize) {
        if self.lazy[node_idx] > 0 {
            if start_idx != end_idx { // Not a leaf node
                let left_child = 2 * node_idx + 1;
                let right_child = 2 * node_idx + 2;

                // Propagate lazy value to children's lazy arrays
                self.lazy[left_child] = self.lazy[left_child].max(self.lazy[node_idx]);
                self.lazy[right_child] = self.lazy[right_child].max(self.lazy[node_idx]);

                // Also update children's tree values based on current node's lazy value
                self.tree[left_child] = self.tree[left_child].max(self.lazy[node_idx]);
                self.tree[right_child] = self.tree[right_child].max(self.lazy[node_idx]);
            }
            // Reset lazy for current node after propagation
            self.lazy[node_idx] = 0;
        }
    }

    // Updates a range [query_start_idx, query_end_idx] with a new maximum value 'val'
    fn update(&mut self, node_idx: usize, start_idx: usize, end_idx: usize,
              query_start_idx: usize, query_end_idx: usize, val: i32) {
        // If current node's range is completely outside the query range
        if start_idx > end_idx || start_idx > query_end_idx || end_idx < query_start_idx {
            return;
        }

        // If current node's range is completely within the query range
        if query_start_idx <= start_idx && end_idx <= query_end_idx {
            // Apply update to current node's tree value and lazy value
            self.tree[node_idx] = self.tree[node_idx].max(val);
            self.lazy[node_idx] = self.lazy[node_idx].max(val);
            return;
        }

        // Propagate lazy updates before recursing
        self.push_down(node_idx, start_idx, end_idx);

        // Partially overlapping, recurse
        let mid_idx = start_idx + (end_idx - start_idx) / 2;
        let left_child = 2 * node_idx + 1;
        let right_child = 2 * node_idx + 2;

        self.update(left_child, start_idx, mid_idx, query_start_idx, query_end_idx, val);
        self.update(right_child, mid_idx + 1, end_idx, query_start_idx, query_end_idx, val);

        // Update current node's max from children
        self.tree[node_idx] = self.tree[left_child].max(self.tree[right_child]);
    }

    // Queries the maximum value in a range [query_start_idx, query_end_idx]
    fn query(&mut self, node_idx: usize, start_idx: usize, end_idx: usize,
             query_start_idx: usize, query_end_idx: usize) -> i32 {
        // If current node's range is completely outside the query range
        if start_idx > end_idx || start_idx > query_end_idx || end_idx < query_start_idx {
            return 0;
        }

        // Propagate lazy updates before processing current node
        self.push_down(node_idx, start_idx, end_idx);

        // If current node's range is completely within the query range
        if query_start_idx <= start_idx && end_idx <= query_end_idx {
            return self.tree[node_idx];
        }

        // Partially overlapping, recurse
        let mid_idx = start_idx + (end_idx - start_idx) / 2;
        let left_child = 2 * node_idx + 1;
        let right_child = 2 * node_idx + 2;

        let left_max = self.query(left_child, start_idx, mid_idx, query_start_idx, query_end_idx);
        let right_max = self.query(right_child, mid_idx + 1, end_idx, query_start_idx, query_end_idx);

        left_max.max(right_max)
    }
}

impl Solution {
    pub fn falling_squares(positions: Vec<Vec<i32>>) -> Vec<i32> {
        let mut coords_set = BTreeSet::new();
        for pos in &positions {
            let left = pos[0];
            let side = pos[1];
            let right = left + side - 1;
            coords_set.insert(left);
            coords_set.insert(right);
        }

        let coords_vec: Vec<i32> = coords_set.into_iter().collect();
        let mut coord_to_idx: HashMap<i32, usize> = HashMap::new();
        for (i, &coord) in coords_vec.iter().enumerate() {
            coord_to_idx.insert(coord, i);
        }

        let num_unique_coords = coords_vec.len();
        // The segment tree operates on indices from 0 to num_unique_coords - 1.
        // If num_unique_coords is 0, this would be an issue, but problem constraints
        // guarantee at least one position.
        let mut segment_tree = SegmentTree::new(num_unique_coords);

        let mut result = Vec::with_capacity(positions.len());
        let mut max_height_overall = 0;

        for pos in positions {
            let left = pos[0];
            let side = pos[1];
            let right = left + side - 1;

            let query_left_idx = *coord_to_idx.get(&left).unwrap();
            let query_right_idx = *coord_to_idx.get(&right).unwrap();

            // Query for the current maximum height in the interval [left, right]
            let current_max_h = segment_tree.query(0, 0, num_unique_coords - 1, query_left_idx, query_right_idx);

            // The new height of the falling square
            let new_square_height = current_max_h + side;

            // Update the segment tree with the new height for the interval [left, right]
            segment_tree.update(0, 0, num_unique_coords - 1, query_left_idx, query_right_idx, new_square_height);

            // Update the overall maximum height
            max_height_overall = max_height_overall.max(new_square_height);
            result.push(max_height_overall);
        }

        result
    }
}