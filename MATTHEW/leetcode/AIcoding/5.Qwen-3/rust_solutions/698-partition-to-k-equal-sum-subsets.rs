impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_partition_k_subsets(mut nums: Vec<i32>, k: i32) -> bool {
        let total = nums.iter().sum::<i32>();
        if total % k != 0 {
            return false;
        }
        let target = total / k;
        nums.sort_by(|a, b| b.cmp(a));
        let mut used = vec![false; nums.len()];

        fn backtrack(
            index: usize,
            current_sum: i32,
            k: i32,
            target: i32,
            nums: &Vec<i32>,
            used: &mut Vec<bool>,
        ) -> bool {
            if k == 0 {
                return true;
            }
            if current_sum == target {
                return backtrack(0, 0, k - 1, target, nums, used);
            }
            for i in index..nums.len() {
                if !used[i] && current_sum + nums[i] <= target {
                    used[i] = true;
                    if backtrack(i + 1, current_sum + nums[i], k, target, nums, used) {
                        return true;
                    }
                    used[i] = false;
                }
            }
            false
        }

        backtrack(0, 0, k, target, &nums, &mut used)
    }
}
}