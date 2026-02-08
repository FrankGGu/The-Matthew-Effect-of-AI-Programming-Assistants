impl Solution {
    pub fn min_max_pair_sum(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut max_sum = 0;
        for i in 0..nums.len() / 2 {
            max_sum = max_sum.max(nums[i] + nums[nums.len() - 1 - i]);
        }
        max_sum
    }
}