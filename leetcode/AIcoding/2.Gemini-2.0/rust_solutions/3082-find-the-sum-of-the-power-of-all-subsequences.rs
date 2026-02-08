impl Solution {
    pub fn sum_power(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut ans: i64 = 0;
        let mut pow_sum: i64 = 0;
        let modulo: i64 = 1_000_000_007;
        for &num in &nums {
            let num_i64 = num as i64;
            ans = (ans + (num_i64 * num_i64 % modulo) * (num_i64 + pow_sum) % modulo) % modulo;
            pow_sum = (pow_sum * 2) % modulo;
            pow_sum = (pow_sum + num_i64) % modulo;
        }
        ans as i32
    }
}