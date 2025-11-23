impl Solution {
    pub fn array_pair_sum(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let mut sum = 0;
        for i in (0..nums.len()).step_by(2) {
            sum += nums[i];
        }
        sum
    }
}