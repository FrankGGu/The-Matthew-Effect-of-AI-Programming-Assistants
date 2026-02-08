impl Solution {
    pub fn permute(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut nums = nums;
        let mut result: Vec<Vec<i32>> = Vec::new();

        fn backtrack(nums: &mut Vec<i32>, result: &mut Vec<Vec<i32>>, start: usize) {
            if start == nums.len() {
                result.push(nums.clone());
                return;
            }

            for i in start..nums.len() {
                nums.swap(start, i);
                backtrack(nums, result, start + 1);
                nums.swap(start, i);
            }
        }

        backtrack(&mut nums, &mut result, 0);
        result
    }
}