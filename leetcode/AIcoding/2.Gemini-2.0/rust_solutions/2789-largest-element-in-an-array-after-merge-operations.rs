impl Solution {
    pub fn largest_element(nums: Vec<i32>) -> i64 {
        let mut nums = nums;
        let n = nums.len();
        for i in (0..n - 1).rev() {
            if nums[i] <= nums[i + 1] {
                nums[i] += nums[i + 1];
            }
        }
        nums[0] as i64
    }
}