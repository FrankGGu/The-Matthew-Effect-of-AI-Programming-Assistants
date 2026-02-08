impl Solution {
    pub fn k_sum(nums: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut nums = nums;
        nums.sort();
        let mut result = Vec::new();
        let mut path = Vec::new();
        Self::backtrack(&nums, k, 0, &mut path, &mut result);
        result
    }

    fn backtrack(nums: &[i32], k: i32, start: usize, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if k == 0 {
            result.push(path.clone());
            return;
        }
        for i in start..nums.len() {
            if i > start && nums[i] == nums[i - 1] {
                continue;
            }
            if nums[i] > k {
                break;
            }
            path.push(nums[i]);
            Self::backtrack(nums, k - nums[i], i + 1, path, result);
            path.pop();
        }
    }
}