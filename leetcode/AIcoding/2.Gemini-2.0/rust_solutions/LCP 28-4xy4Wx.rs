impl Solution {
    pub fn purchase_plans(nums: Vec<i32>, target: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 0;
        let mut left = 0;
        let mut right = nums.len() - 1;
        while left < right {
            if nums[left] + nums[right] <= target {
                count = (count + right - left) % 1000000007;
                left += 1;
            } else {
                right -= 1;
            }
        }
        count as i32
    }
}