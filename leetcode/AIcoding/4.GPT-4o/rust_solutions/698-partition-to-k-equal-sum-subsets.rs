impl Solution {
    pub fn can_partition_k_subsets(nums: Vec<i32>, k: i32) -> bool {
        let total_sum: i32 = nums.iter().sum();
        if total_sum % k != 0 || k == 0 {
            return false;
        }
        let target = total_sum / k;
        let mut subsets = vec![0; k as usize];
        let mut nums = nums;
        nums.sort_unstable_by(|a, b| b.cmp(a));

        fn backtrack(nums: &Vec<i32>, subsets: &mut Vec<i32>, index: usize, target: i32) -> bool {
            if index == nums.len() {
                return subsets.iter().all(|&sum| sum == target);
            }
            for i in 0..subsets.len() {
                if subsets[i] + nums[index] <= target {
                    subsets[i] += nums[index];
                    if backtrack(nums, subsets, index + 1, target) {
                        return true;
                    }
                    subsets[i] -= nums[index];
                }
                if subsets[i] == 0 {
                    break;
                }
            }
            false
        }

        backtrack(&nums, &mut subsets, 0, target)
    }
}