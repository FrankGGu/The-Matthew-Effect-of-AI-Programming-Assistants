use std::collections::{HashMap, HashSet};

struct SegmentTree {
    tree: Vec<i64>,
    n: usize,
}

impl SegmentTree {
    fn new(size: usize) -> Self {
        // Allocate memory for the segment tree. A common heuristic is 4 * size.
        // If size is 0, allocate for a minimal tree (size 1) to avoid issues with `vec![0; 0]`
        // or `self.n - 1` if `n` is 0. The public methods will guard against `n=0`.
        let actual_tree_size = if size == 0 { 4 } else { 4 * size };
        SegmentTree {
            tree: vec![0; actual_tree_size],
            n: size,
        }
    }

    // Recursively updates the segment tree.
    // `node`: current node index in the `tree` vector.
    // `start`, `end`: range represented by the current node.
    // `idx`: the specific index to update (compressed value index).
    // `val`: the new value to update with (max sum ending at `idx`).
    fn update_recursive(&mut self, node: usize, start: usize, end: usize, idx: usize, val: i64) {
        if start == end {
            // Leaf node: update with the maximum value seen for this index.
            self.tree[node] = self.tree[node].max(val);
        } else {
            let mid = start + (end - start) / 2;
            if start <= idx && idx <= mid {
                // `idx` is in the left child's range.
                self.update_recursive(2 * node, start, mid, idx, val);
            } else {
                // `idx` is in the right child's range.
                self.update_recursive(2 * node + 1, mid + 1, end, idx, val);
            }
            // Update the parent node with the maximum of its children.
            self.tree[node] = self.tree[2 * node].max(self.tree[2 * node + 1]);
        }
    }

    // Public method to update a value at a given index.
    fn update(&mut self, idx: usize, val: i64) {
        if self.n == 0 {
            return; // No-op if the tree is empty (no unique values).
        }
        self.update_recursive(1, 0, self.n - 1, idx, val);
    }

    // Recursively queries the segment tree for the maximum value in a range [l, r].
    // `node`: current node index.
    // `start`, `end`: range represented by the current node.
    // `l`, `r`: query range.
    fn query_recursive(&self, node: usize, start: usize, end: usize, l: usize, r: usize) -> i64 {
        // If the current segment is completely outside the query range.
        if r < start || end < l {
            return 0;
        }
        // If the current segment is completely inside the query range.
        if l <= start && end <= r {
            return self.tree[node];
        }
        // Partially overlapping, query children and combine results.
        let mid = start + (end - start) / 2;
        let p1 = self.query_recursive(2 * node, start, mid, l, r);
        let p2 = self.query_recursive(2 * node + 1, mid + 1, end, l, r);
        p1.max(p2)
    }

    // Public method to query the maximum value in a range [l, r].
    fn query(&self, l: usize, r: usize) -> i64 {
        // Handle invalid query ranges or an empty tree.
        if self.n == 0 || l > r || l >= self.n {
            return 0;
        }
        self.query_recursive(1, 0, self.n - 1, l, r.min(self.n - 1))
    }
}

impl Solution {
    pub fn find_minimum_cost_to_remove_array_elements(nums: Vec<i32>) -> i64 {
        if nums.is_empty() {
            return 0;
        }

        let total_sum: i64 = nums.iter().map(|&x| x as i64).sum();

        // Coordinate compression:
        // 1. Collect unique values from `nums`.
        let mut unique_values_set: HashSet<i32> = nums.iter().cloned().collect();
        let mut unique_values: Vec<i32> = unique_values_set.into_iter().collect();
        // 2. Sort unique values to create a mapping to contiguous indices.
        unique_values.sort_unstable();

        // 3. Create a map from original value to its compressed index.
        let mut val_to_idx: HashMap<i32, usize> = HashMap::new();
        for (i, &val) in unique_values.iter().enumerate() {
            val_to_idx.insert(val, i);
        }

        let num_unique_values = unique_values.len();
        let mut segment_tree = SegmentTree::new(num_unique_values);

        let mut max_non_decreasing_subsequence_sum: i64 = 0;

        // Iterate through the original array to build the maximum sum non-decreasing subsequence.
        for &num in nums.iter() {
            let compressed_idx = *val_to_idx.get(&num).unwrap();

            // Query the segment tree for the maximum sum of a non-decreasing subsequence
            // that ends with a value less than or equal to `num`.
            // This corresponds to querying the range [0, compressed_idx] in the segment tree.
            let prev_max_sum = segment_tree.query(0, compressed_idx);

            // Calculate the current maximum sum of a non-decreasing subsequence ending with `num`.
            // This is `num` itself plus the maximum sum of a valid preceding subsequence.
            let current_dp_sum = num as i64 + prev_max_sum;

            // Update the segment tree at `compressed_idx` with `current_dp_sum`.
            // The segment tree stores the maximum sum for any subsequence ending with the value
            // represented by `compressed_idx`. If multiple subsequences end with the same value,
            // we care about the one with the maximum sum.
            segment_tree.update(compressed_idx, current_dp_sum);

            // Keep track of the overall maximum sum found so far across all possible ending elements.
            max_non_decreasing_subsequence_sum = max_non_decreasing_subsequence_sum.max(current_dp_sum);
        }

        // The minimum cost to remove elements is the total sum of all elements
        // minus the maximum sum of a non-decreasing subsequence that is kept.
        total_sum - max_non_decreasing_subsequence_sum
    }
}