impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        (nums[n - 1] - 1) * (nums[n - 2] - 1)
    }
}