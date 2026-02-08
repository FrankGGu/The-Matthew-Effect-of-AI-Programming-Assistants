use std::collections::{HashMap, HashSet};

struct SegmentTree {
    tree: Vec<i64>,
    n: usize,
}

impl SegmentTree {
    fn new(size: usize) -> Self {
        SegmentTree {
            tree: vec![std::i64::MIN; 4 * size],
            n: size,
        }
    }

    fn update(&mut self, index: usize, val: i64) {
        self._update(1, 0, self.n - 1, index, val);
    }

    fn _update(&mut self, node: usize, start: usize, end: usize, index: usize, val: i64) {
        if start == end {
            self.tree[node] = self.tree[node].max(val);
            return;
        }

        let mid = start + (end - start) / 2;
        if start <= index && index <= mid {
            self._update(2 * node, start, mid, index, val);
        } else {
            self._update(2 * node + 1, mid + 1, end, index, val);
        }
        self.tree[node] = self.tree[2 * node].max(self.tree[2 * node + 1]);
    }

    fn query(&mut self, l: usize, r: usize) -> i64 {
        self._query(1, 0, self.n - 1, l, r)
    }

    fn _query(&mut self, node: usize, start: usize, end: usize, l: usize, r: usize) -> i64 {
        if r < start || end < l {
            return std::i64::MIN;
        }

        if l <= start && end <= r {
            return self.tree[node];
        }

        let mid = start + (end - start) / 2;
        let p1 = self._query(2 * node, start, mid, l, r);
        let p2 = self._query(2 * node + 1, mid + 1, end, l, r);
        p1.max(p2)
    }
}

impl Solution {
    pub fn max_balanced_subsequence_sum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        if n == 0 {
            return 0; 
        }

        let mut transformed_vals: Vec<i64> = Vec::with_capacity(n);
        for i in 0..n {
            transformed_vals.push(nums[i] as i64 - i as i64);
        }

        let mut unique_transformed_vals: Vec<i64> = transformed_vals.iter().cloned().collect();
        unique_transformed_vals.sort_unstable();
        unique_transformed_vals.dedup();

        let mut val_to_compressed_idx: HashMap<i64, usize> = HashMap::new();
        for (idx, &val) in unique_transformed_vals.iter().enumerate() {
            val_to_compressed_idx.insert(val, idx);
        }

        let m = unique_transformed_vals.len();
        let mut segment_tree = SegmentTree::new(m);

        let mut max_overall_sum: i64 = std::i64::MIN;

        for i in 0..n {
            let current_num = nums[i] as i64;
            let current_transformed_val = transformed_vals[i];
            let compressed_idx = *val_to_compressed_idx.get(&current_transformed_val).unwrap();

            let max_prev_sum = segment_tree.query(0, compressed_idx);

            let current_dp_sum = current_num + max_prev_sum.max(0);

            segment_tree.update(compressed_idx, current_dp_sum);

            max_overall_sum = max_overall_sum.max(current_dp_sum);
        }

        max_overall_sum
    }
}