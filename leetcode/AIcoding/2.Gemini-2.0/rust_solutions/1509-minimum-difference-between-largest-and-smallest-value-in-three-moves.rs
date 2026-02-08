impl Solution {
    pub fn min_difference(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 4 {
            return 0;
        }
        nums.sort();
        let mut ans = i32::MAX;
        ans = ans.min(nums[n - 1] - nums[3]);
        ans = ans.min(nums[n - 2] - nums[2]);
        ans = ans.min(nums[n - 3] - nums[1]);
        ans = ans.min(nums[n - 4] - nums[0]);
        ans
    }
}