struct Solution {}

impl Solution {
    pub fn triangular_sum(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let n = nums.len();
        for i in 1..n {
            for j in 0..n - i {
                nums[j] = nums[j] + nums[j + 1];
            }
        }
        nums[0]
    }
}