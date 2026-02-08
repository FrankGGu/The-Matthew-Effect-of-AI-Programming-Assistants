use std::collections::HashSet;

impl Solution {
    pub fn minimal_k_sum(nums: Vec<i32>, k: i32) -> i64 {
        let mut unique_nums = HashSet::new();
        for &num in nums.iter() {
            unique_nums.insert(num);
        }
        let mut sorted_nums: Vec<i32> = unique_nums.into_iter().collect();
        sorted_nums.sort_unstable();

        let mut res = 0i64;
        let mut prev = 0i64;
        let mut remaining = k as i64;

        for &num in sorted_nums.iter() {
            let num = num as i64;
            if num > prev + 1 {
                let count = (num - prev - 1).min(remaining);
                res += (prev + 1 + prev + count) * count / 2;
                remaining -= count;
                if remaining == 0 {
                    break;
                }
            }
            prev = num;
        }

        if remaining > 0 {
            res += (prev + 1 + prev + remaining) * remaining / 2;
        }

        res
    }
}