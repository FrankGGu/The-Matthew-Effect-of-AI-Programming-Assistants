impl Solution {
    pub fn count_pairs(nums: Vec<i32>, target: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 0;
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;

        while left < right {
            if nums[left] + nums[right as usize] < target {
                count += (right - left) as i32;
                left += 1;
            } else {
                right -= 1;
            }
        }

        count
    }
}