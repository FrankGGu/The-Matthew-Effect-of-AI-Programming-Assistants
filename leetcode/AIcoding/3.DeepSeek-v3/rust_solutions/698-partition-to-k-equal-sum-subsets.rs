impl Solution {
    pub fn can_partition_k_subsets(nums: Vec<i32>, k: i32) -> bool {
        let total: i32 = nums.iter().sum();
        if total % k != 0 {
            return false;
        }
        let target = total / k;
        let mut nums = nums;
        nums.sort_by(|a, b| b.cmp(a));
        let mut visited = vec![false; nums.len()];
        Self::backtrack(&nums, 0, k, target, 0, &mut visited)
    }

    fn backtrack(nums: &Vec<i32>, start: usize, k: i32, target: i32, current_sum: i32, visited: &mut Vec<bool>) -> bool {
        if k == 1 {
            return true;
        }
        if current_sum == target {
            return Self::backtrack(nums, 0, k - 1, target, 0, visited);
        }
        for i in start..nums.len() {
            if visited[i] || current_sum + nums[i] > target {
                continue;
            }
            visited[i] = true;
            if Self::backtrack(nums, i + 1, k, target, current_sum + nums[i], visited) {
                return true;
            }
            visited[i] = false;
        }
        false
    }
}