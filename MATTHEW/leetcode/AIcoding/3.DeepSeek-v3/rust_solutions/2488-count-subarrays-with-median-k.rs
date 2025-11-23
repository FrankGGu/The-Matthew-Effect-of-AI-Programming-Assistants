use std::collections::HashMap;

impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut pos = 0;
        for i in 0..n {
            if nums[i] == k {
                pos = i;
                break;
            }
        }

        let mut res = 0;
        let mut balance = 0;
        let mut count = HashMap::new();
        count.insert(0, 1);

        for i in 0..n {
            if nums[i] < k {
                balance -= 1;
            } else if nums[i] > k {
                balance += 1;
            }

            if i < pos {
                *count.entry(balance).or_insert(0) += 1;
            } else {
                res += *count.get(&balance).unwrap_or(&0);
                res += *count.get(&(balance - 1)).unwrap_or(&0);
            }
        }

        res
    }
}