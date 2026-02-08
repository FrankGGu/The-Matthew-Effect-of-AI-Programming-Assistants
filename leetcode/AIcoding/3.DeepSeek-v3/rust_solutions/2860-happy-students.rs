impl Solution {
    pub fn count_happy_groups(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let n = nums.len();
        let mut happy = 0;
        let mut left = 0;
        let mut right = n - 1;

        while left <= right {
            if nums[left] + nums[right] > 0 {
                happy += 1;
                right -= 1;
            } else {
                left += 1;
            }
        }

        happy
    }
}