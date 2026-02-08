impl Solution {
    pub fn count_max_or_subsets(nums: Vec<i32>) -> i32 {
        let max_or = nums.iter().fold(0, |acc, &num| acc | num);
        let mut count = 0;

        fn backtrack(nums: &[i32], index: usize, current_or: i32, max_or: i32, count: &mut i32) {
            if current_or == max_or {
                *count += 1;
            }
            for i in index..nums.len() {
                backtrack(nums, i + 1, current_or | nums[i], max_or, count);
            }
        }

        backtrack(&nums, 0, 0, max_or, &mut count);
        count
    }
}