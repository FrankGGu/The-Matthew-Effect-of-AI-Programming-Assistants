impl Solution {
    pub fn permute_unique(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut nums = nums;
        nums.sort();
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current: Vec<i32> = Vec::new();
        let mut used: Vec<bool> = vec![false; nums.len()];

        fn backtrack(nums: &Vec<i32>, used: &mut Vec<bool>, current: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            if current.len() == nums.len() {
                result.push(current.clone());
                return;
            }

            for i in 0..nums.len() {
                if used[i] {
                    continue;
                }
                if i > 0 && nums[i] == nums[i - 1] && !used[i - 1] {
                    continue;
                }

                used[i] = true;
                current.push(nums[i]);
                backtrack(nums, used, current, result);
                current.pop();
                used[i] = false;
            }
        }

        backtrack(&nums, &mut used, &mut current, &mut result);
        result
    }
}