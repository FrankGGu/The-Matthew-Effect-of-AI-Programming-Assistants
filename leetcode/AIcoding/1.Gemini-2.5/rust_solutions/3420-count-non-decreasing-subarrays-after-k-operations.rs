use std::collections::{HashMap, HashSet};

struct FenwickTreeMax {
    size: usize,
    tree: Vec<i32>,
}

impl FenwickTreeMax {
    fn new(size: usize) -> Self {
        FenwickTreeMax {
            size,
            tree: vec![0; size + 1],
        }
    }

    fn update(&mut self, mut idx: usize, val: i32) {
        while idx <= self.size {
            self.tree[idx] = self.tree[idx].max(val);
            idx += idx & (!idx + 1); // Equivalent to idx += idx & (-idx)
        }
    }

    fn query(&self, mut idx: usize) -> i32 {
        let mut res = 0;
        while idx > 0 {
            res = res.max(self.tree[idx]);
            idx -= idx & (!idx + 1); // Equivalent to idx -= idx & (-idx)
        }
        res
    }
}

impl Solution {
    pub fn count_non_decreasing_subarrays_after_k_operations(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();

        let mut unique_vals: Vec<i32> = Vec::new();
        for &num in nums.iter() {
            unique_vals.push(num);
        }
        unique_vals.sort_unstable();
        unique_vals.dedup();

        let mut val_to_compressed_idx: HashMap<i32, usize> = HashMap::new();
        for (idx, &val) in unique_vals.iter().enumerate() {
            val_to_compressed_idx.insert(val, idx);
        }

        let compressed_nums: Vec<usize> = nums
            .iter()
            .map(|&val| *val_to_compressed_idx.get(&val).unwrap())
            .collect();

        let m = unique_vals.len(); // Number of unique compressed values

        let mut total_count: i64 = 0;

        for i in 0..n {
            let mut bit = FenwickTreeMax::new(m);
            for j in i..n {
                let val_compressed = compressed_nums[j];

                // Query max LIS length ending with a value <= current_val
                // Fenwick tree is 1-indexed, so we use val_compressed + 1
                let max_len_ending_before_val = bit.query(val_compressed + 1);

                let current_lis_len = max_len_ending_before_val + 1;

                // Update Fenwick tree with the new LIS length ending at current_val
                bit.update(val_compressed + 1, current_lis_len);

                // The total LIS length for the subarray nums[i...j] is the maximum value in the BIT
                let total_lis_in_window = bit.query(m);

                let cost = (j - i + 1) as i32 - total_lis_in_window;

                if cost <= k {
                    total_count += 1;
                }
            }
        }

        total_count
    }
}