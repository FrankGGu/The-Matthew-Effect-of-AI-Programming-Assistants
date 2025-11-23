impl Solution {
    pub fn permute(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut nums = nums;
        let mut result: Vec<Vec<i32>> = Vec::new();

        fn backtrack(nums: &mut Vec<i32>, result: &mut Vec<Vec<i32>>, first: usize) {
            if first == nums.len() {
                result.push(nums.clone());
                return;
            }

            for i in first..nums.len() {
                nums.swap(first, i);
                backtrack(nums, result, first + 1);
                nums.swap(first, i);
            }
        }

        backtrack(&mut nums, &mut result, 0);
        result
    }
}