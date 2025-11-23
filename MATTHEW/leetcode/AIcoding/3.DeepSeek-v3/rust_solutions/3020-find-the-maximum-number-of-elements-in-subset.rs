use std::collections::HashSet;

impl Solution {
    pub fn maximum_length(nums: Vec<i32>) -> i32 {
        let num_set: HashSet<_> = nums.iter().cloned().collect();
        let mut max_len = 1;

        for &num in nums.iter() {
            if num == 1 {
                continue;
            }
            let mut current = num;
            let mut len = 0;

            while num_set.contains(&current) {
                len += 1;
                if current > i32::MAX / current {
                    break;
                }
                current *= current;
            }

            if len % 2 == 0 {
                max_len = max_len.max(len - 1);
            } else {
                max_len = max_len.max(len);
            }
        }

        let count_ones = nums.iter().filter(|&&x| x == 1).count() as i32;
        if count_ones > 0 {
            if count_ones % 2 == 1 {
                max_len = max_len.max(count_ones);
            } else {
                max_len = max_len.max(count_ones - 1);
            }
        }

        max_len
    }
}