impl Solution {
    pub fn sum_of_power(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut ans: i64 = 0;
        let mut sum: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for &num in &nums {
            let num_i64 = num as i64;
            ans = (ans + num_i64 * num_i64 % modulo * (sum + num_i64)) % modulo;
            sum = (sum * 2 + num_i64) % modulo;
        }

        ans as i32
    }
}