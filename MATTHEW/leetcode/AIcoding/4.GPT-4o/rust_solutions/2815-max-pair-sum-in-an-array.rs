impl Solution {
    pub fn max_pair_sum(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let n = nums.len();
        let mut max_sum = 0;

        for i in 0..n/2 {
            max_sum = max_sum.max(nums[i] + nums[n - 1 - i]);
        }

        max_sum
    }
}