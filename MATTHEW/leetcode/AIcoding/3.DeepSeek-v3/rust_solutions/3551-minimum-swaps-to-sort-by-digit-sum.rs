use std::collections::HashMap;

impl Solution {
    pub fn min_swaps(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut digit_sums: Vec<i32> = nums.iter().map(|&x| Self::digit_sum(x)).collect();
        let mut sorted_nums = nums.clone();
        let mut sorted_sums = digit_sums.clone();

        let mut original_indices: Vec<usize> = (0..n).collect();
        original_indices.sort_by_key(|&i| (digit_sums[i], nums[i]));

        sorted_nums.sort_by_key(|&x| (Self::digit_sum(x), x));
        sorted_sums.sort();

        let mut visited = vec![false; n];
        let mut swaps = 0;

        for i in 0..n {
            if !visited[i] {
                let mut j = i;
                let mut cycle_size = 0;

                while !visited[j] {
                    visited[j] = true;
                    j = original_indices[j];
                    cycle_size += 1;
                }

                if cycle_size > 0 {
                    swaps += cycle_size - 1;
                }
            }
        }

        swaps as i32
    }

    fn digit_sum(mut num: i32) -> i32 {
        let mut sum = 0;
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        sum
    }
}