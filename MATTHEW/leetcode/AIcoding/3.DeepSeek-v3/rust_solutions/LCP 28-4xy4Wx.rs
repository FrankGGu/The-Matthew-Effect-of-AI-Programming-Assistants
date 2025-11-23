impl Solution {
    pub fn purchase_plans(nums: Vec<i32>, target: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;
        let mut res = 0;
        let modulo = 1_000_000_007;
        while left < right {
            if nums[left as usize] + nums[right as usize] > target {
                right -= 1;
            } else {
                res += right - left;
                res %= modulo;
                left += 1;
            }
        }
        res as i32
    }
}