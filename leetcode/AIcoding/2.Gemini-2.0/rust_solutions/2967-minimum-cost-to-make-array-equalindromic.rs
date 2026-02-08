impl Solution {
    pub fn minimum_cost(nums: Vec<i32>) -> i64 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let median = nums[n / 2];

        let mut cost = 0;
        for &num in &nums {
            cost += (num as i64 - median as i64).abs();
        }

        cost
    }
}