use std::collections::HashMap;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut even_counts: HashMap<i32, i32> = HashMap::new();
        let mut odd_counts: HashMap<i32, i32> = HashMap::new();

        for i in 0..n {
            if i % 2 == 0 {
                *even_counts.entry(nums[i]).or_insert(0) += 1;
            } else {
                *odd_counts.entry(nums[i]).or_insert(0) += 1;
            }
        }

        let mut even_freqs: Vec<(i32, i32)> = even_counts.into_iter().map(|(val, count)| (count, val)).collect();
        even_freqs.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut odd_freqs: Vec<(i32, i32)> = odd_counts.into_iter().map(|(val, count)| (count, val)).collect();
        odd_freqs.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let (c_e1, v_e1) = even_freqs.get(0).copied().unwrap_or((0, -1));
        let (c_e2, _v_e2) = even_freqs.get(1).copied().unwrap_or((0, -2)); // Value doesn't matter, only count

        let (c_o1, v_o1) = odd_freqs.get(0).copied().unwrap_or((0, -3));
        let (c_o2, _v_o2) = odd_freqs.get(1).copied().unwrap_or((0, -4)); // Value doesn't matter, only count

        let num_even_slots = (n + 1) as i32 / 2;
        let num_odd_slots = n as i32 / 2;

        let mut min_ops = 0;

        if v_e1 != v_o1 {
            min_ops = (num_even_slots - c_e1) + (num_odd_slots - c_o1);
        } else {
            // Case where most frequent elements for even and odd indices are the same.
            // Option 1: Use v_e1 for even indices, and the second most frequent for odd indices.
            let ops1 = (num_even_slots - c_e1) + (num_odd_slots - c_o2);
            // Option 2: Use v_o1 for odd indices, and the second most frequent for even indices.
            let ops2 = (num_even_slots - c_e2) + (num_odd_slots - c_o1);
            min_ops = ops1.min(ops2);
        }

        min_ops
    }
}