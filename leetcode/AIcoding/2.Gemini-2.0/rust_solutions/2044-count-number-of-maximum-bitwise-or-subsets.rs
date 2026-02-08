impl Solution {
    pub fn count_max_or_subsets(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_or = 0;
        for &num in &nums {
            max_or |= num;
        }

        let mut count = 0;

        fn solve(nums: &Vec<i32>, index: usize, current_or: i32, max_or: i32, count: &mut i32) {
            if index == nums.len() {
                if current_or == max_or {
                    *count += 1;
                }
                return;
            }

            solve(nums, index + 1, current_or | nums[index], max_or, count);
            solve(nums, index + 1, current_or, max_or, count);
        }

        solve(&nums, 0, 0, max_or, &mut count);
        count
    }
}