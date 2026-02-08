impl Solution {
    pub fn special_permute(nums: Vec<i32>) -> Vec<Vec<i32>> {
        fn backtrack(start: usize, nums: &mut Vec<i32>, result: &mut Vec<Vec<i32>>, n: usize) {
            if start == n {
                result.push(nums.clone());
                return;
            }
            for i in start..n {
                nums.swap(start, i);
                if start == 0 || (nums[start] % 2 != nums[start - 1] % 2) {
                    backtrack(start + 1, nums, result, n);
                }
                nums.swap(start, i);
            }
        }

        let mut result = Vec::new();
        let mut nums = nums.clone();
        backtrack(0, &mut nums, &mut result, nums.len());
        result
    }
}