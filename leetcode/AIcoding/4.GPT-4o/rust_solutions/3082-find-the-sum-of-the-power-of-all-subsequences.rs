impl Solution {
    pub fn sum_of_power(nums: Vec<i32>) -> i64 {
        let mod_val = 1_000_000_007;
        let n = nums.len();
        let mut nums = nums;
        nums.sort_unstable();

        let mut total_sum = 0;
        let mut power_of_two = 1;

        for i in 0..n {
            total_sum = (total_sum + (power_of_two * nums[i] as i64 % mod_val) % mod_val * (i as i64 + 1) % mod_val) % mod_val;
            power_of_two = (power_of_two * 2) % mod_val;
        }

        total_sum
    }
}