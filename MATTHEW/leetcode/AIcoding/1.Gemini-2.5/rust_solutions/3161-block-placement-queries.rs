use std::collections::{BTreeSet, HashMap};

#[derive(Clone)]
struct Node {
    max_prefix_free: i64,
    max_suffix_free: i64,
    max_total_free: i64,
    is_all_occupied: bool,
    lazy: Option<bool>,
    left: Option<Box<Node>>,
    right: Option<Box<Node>>,
}

impl Node {
    fn new(len: i64) -> Self {
        Node {
            max_prefix_free: len,
            max_suffix_free: len,
            max_total_free: len,
            is_all_occupied: false,
            lazy: None,
            left: None,
            right: None,
        }
    }

    fn default_occupied() -> Self {
        Node {
            max_prefix_free: 0,
            max_suffix_free: 0,
            max_total_free: 0,
            is_all_occupied: true,
            lazy: None,
            left: None,
            right: None,
        }
    }
}

struct SegmentTree {
    root: Option<Box<Node>>,
    coords: Vec<i32>,
    n_road: i32,
}

impl SegmentTree {
    fn new(coords: Vec<i32>, n_road: i32) -> Self {
        SegmentTree {
            root: None,
            coords,
            n_road,
        }
    }

    fn get_actual_len(&self, start_idx: usize, end_idx: usize) -> i64 {
        if start_idx >= self.coords.len() - 1 || end_idx >= self.coords.len() - 1 || start_idx > end_idx {
            return 0;
        }
        (self.coords[end_idx + 1] - self.coords[start_idx]) as i64
    }

    fn apply_lazy_to_node(node: &mut Node, len: i64, occupy: bool) {
        node.lazy = Some(occupy);
        if occupy {
            node.max_prefix_free = 0;
            node.max_suffix_free = 0;
            node.max_total_free = 0;
            node.is_all_occupied = true;
        } else {
            node.max_prefix_free = len;
            node.max_suffix_free = len;
            node.max_total_free = len;
            node.is_all_occupied = false;
        }
    }

    fn push_down(&mut self, node: &mut Node, start_idx: usize, end_idx: usize) {
        if let Some(occupy) = node.lazy.take() {
            let mid_idx = start_idx + (end_idx - start_idx) / 2;

            let left_len = self.get_actual_len(start_idx, mid_idx);
            if node.left.is_none() {
                node.left = Some(Box::new(Node::new(left_len)));
            }
            Self::apply_lazy_to_node(node.left.as_mut().unwrap(), left_len, occupy);

            let right_len = self.get_actual_len(mid_idx + 1, end_idx);
            if node.right.is_none() {
                node.right = Some(Box::new(Node::new(right_len)));
            }
            Self::apply_lazy_to_node(node.right.as_mut().unwrap(), right_len, occupy);
        }
    }

    fn merge_nodes(&self, left_node: &Node, right_node: &Node, left_actual_len: i64, right_actual_len: i64) -> Node {
        let mut res = Node::default_occupied();

        res.is_all_occupied = left_node.is_all_occupied && right_node.is_all_occupied;

        res.max_prefix_free = left_node.max_prefix_free;
        if left_node.max_prefix_free == left_actual_len {
            res.max_prefix_free += right_node.max_prefix_free;
        }

        res.max_suffix_free = right_node.max_suffix_free;
        if right_node.max_suffix_free == right_actual_len {
            res.max_suffix_free += left_node.max_suffix_free;
        }

        res.max_total_free = left_node.max_total_free
            .max(right_node.max_total_free)
            .max(left_node.max_suffix_free + right_node.max_prefix_free);

        res
    }

    fn update_range_recursive(&mut self, node_opt: &mut Option<Box<Node>>, start_idx: usize, end_idx: usize, query_L_idx: usize, query_R_idx: usize, occupy: bool) {
        let current_actual_len = self.get_actual_len(start_idx, end_idx);
        if node_opt.is_none() {
            *node_opt = Some(Box::new(Node::new(current_actual_len)));
        }
        let node = node_opt.as_mut().unwrap();

        if start_idx > query_R_idx || end_idx < query_L_idx {
            return;
        }

        if query_L_idx <= start_idx && end_idx <= query_R_idx {
            Self::apply_lazy_to_node(node, current_actual_len, occupy);
            return;
        }

        self.push_down(node, start_idx, end_idx);

        let mid_idx = start_idx + (end_idx - start_idx) / 2;
        self.update_range_recursive(&mut node.left, start_idx, mid_idx, query_L_idx, query_R_idx, occupy);
        self.update_range_recursive(&mut node.right, mid_idx + 1, end_idx, query_L_idx, query_R_idx, occupy);

        let left_child_node = node.left.as_ref().map_or_else(|| Node::new(self.get_actual_len(start_idx, mid_idx)), |n| n.as_ref().clone());
        let right_child_node = node.right.as_ref().map_or_else(|| Node::new(self.get_actual_len(mid_idx + 1, end_idx)), |n| n.as_ref().clone());

        let merged = self.merge_nodes(&left_child_node, &right_child_node, self.get_actual_len(start_idx, mid_idx), self.get_actual_len(mid_idx + 1, end_idx));
        node.max_prefix_free = merged.max_prefix_free;
        node.max_suffix_free = merged.max_suffix_free;
        node.max_total_free = merged.max_total_free;
        node.is_all_occupied = merged.is_all_occupied;
    }

    fn query_range_info_recursive(&mut self, node_opt: &mut Option<Box<Node>>, start_idx: usize, end_idx: usize, query_L_idx: usize, query_R_idx: usize) -> Node {
        let current_actual_len = self.get_actual_len(start_idx, end_idx);

        if start_idx > query_R_idx || end_idx < query_L_idx {
            return Node::default_occupied();
        }

        if node_opt.is_none() {
            return Node::new(current_actual_len);
        }
        let node = node_opt.as_mut().unwrap();

        if query_L_idx <= start_idx && end_idx <= query_R_idx {
            return node.as_ref().clone();
        }

        self.push_down(node, start_idx, end_idx);

        let mid_idx = start_idx + (end_idx - start_idx) / 2;
        let left_res = self.query_range_info_recursive(&mut node.left, start_idx, mid_idx, query_L_idx, query_R_idx);
        let right_res = self.query_range_info_recursive(&mut node.right, mid_idx + 1, end_idx, query_L_idx, query_R_idx);

        self.merge_nodes(&left_res, &right_res, self.get_actual_len(start_idx, mid_idx), self.get_actual_len(mid_idx + 1, end_idx))
    }
}

impl Solution {
    pub fn block_placement_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let mut coords_set: BTreeSet<i32> = BTreeSet::new();
        coords_set.insert(1);
        coords_set.insert(n + 1);

        for query in &queries {
            if query[0] == 0 { // Place block
                let pos = query[1];
                let size = query[2];
                coords_set.insert(pos);
                coords_set.insert(pos + size);
            } else { // Query
                let pos = query[1];
                let size = query[2];
                coords_set.insert(pos);
                coords_set.insert(pos + size);
                coords_set.insert(pos + size + 1);
            }
        }

        let coords_vec: Vec<i32> = coords_set.into_iter().collect();
        let coord_to_idx: HashMap<i32, usize> = coords_vec.iter().enumerate().map(|(i, &c)| (c, i)).collect();

        let mut seg_tree = SegmentTree::new(coords_vec, n);
        let max_compressed_idx = seg_tree.coords.len() - 2;

        let mut results = Vec::new();

        for query in queries {
            if query[0] == 0 { // Place block
                let pos = query[1];
                let size = query[2];
                let block_start_original = pos;
                let block_end_original = pos + size - 1;

                let query_L_idx = *coord_to_idx.get(&block_start_original).unwrap();
                let query_R_idx = *coord_to_idx.get(&(block_end_original + 1)).unwrap() - 1;

                seg_tree.update_range_recursive(&mut seg_tree.root, 0, max_compressed_idx, query_L_idx, query_R_idx, true);

            } else { // Query
                let pos = query[1];
                let size = query[2];

                let block1_start_original = pos;
                let block1_end_original = pos + size - 1;

                if block1_end_original > n {
                    results.push(false);
                    continue;
                }

                let query_L_idx_b1 = *coord_to_idx.get(&block1_start_original).unwrap();
                let query_R_idx_b1 = *coord_to_idx.get(&(block1_end_original + 1)).unwrap() - 1;

                let block1_info = seg_tree.query_range_info_recursive(&mut seg_tree.root, 0, max_compressed_idx, query_L_idx_b1, query_R_idx_b1);

                if block1_info.is_all_occupied {
                    results.push(false);
                    continue;
                }

                let block2_start_original = pos + size;

                if block2_start_original > n {
                    results.push(true); 
                    continue;
                }

                let query_L_idx_b2 = *coord_to_idx.get(&block2_start_original).unwrap();
                let query_R_idx_b2 = max_compressed_idx;

                let block2_info = seg_tree.query_range_info_recursive(&mut seg_tree.root, 0, max_compressed_idx, query_L_idx_b2, query_R_idx_b2);

                let max_k_val = block2_start_original as i64 + block2_info.max_prefix_free - 1;

                results.push(max_k_val >= n as i64);
            }
        }
        results
    }
}