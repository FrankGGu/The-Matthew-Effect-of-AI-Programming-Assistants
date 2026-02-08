use std::collections::BTreeSet;

impl Solution {
    pub fn count_operations_to_empty_array(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut sorted_indices: Vec<usize> = (0..n).collect();
        sorted_indices.sort_by_key(|&i| nums[i]);

        let mut res = 0;
        let mut removed = BTreeSet::new();
        let mut prev = 0;

        for &i in &sorted_indices {
            let mut current = i as i64;
            let count = removed.range(prev..current).count() as i64;
            if prev <= current {
                current -= count;
            } else {
                current += (removed.len() as i64) - count;
            }
            res += current - prev + 1;
            prev = current;
            removed.insert(i);
        }

        res
    }
}