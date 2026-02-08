impl Solution {
    pub fn can_partition_k_subsets(nums: Vec<i32>, k: i32) -> bool {
        let sum: i32 = nums.iter().sum();
        let k = k as usize;

        if sum % (k as i32) != 0 {
            return false;
        }

        let target = sum / (k as i32);
        let n = nums.len();
        let mut used = vec![false; n];

        nums.sort_by(|a, b| b.cmp(a));

        if nums[0] > target {
            return false;
        }

        fn backtrack(nums: &Vec<i32>, used: &mut Vec<bool>, k: usize, target: i32, current_sum: i32, start_index: usize) -> bool {
            if k == 0 {
                return true;
            }

            if current_sum == target {
                return backtrack(nums, used, k - 1, target, 0, 0);
            }

            for i in start_index..nums.len() {
                if used[i] || current_sum + nums[i] > target {
                    continue;
                }

                used[i] = true;
                if backtrack(nums, used, k, target, current_sum + nums[i], i + 1) {
                    return true;
                }
                used[i] = false;
            }

            false
        }

        backtrack(&nums, &mut used, k, target, 0, 0)
    }
}