const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn sum_of_array_products(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0i64; n + 1];
        let mut stack: Vec<usize> = Vec::new();
        stack.push(0);
        for i in 1..=n {
            while stack.len() > 1 && nums[stack[stack.len() - 1] - 1] > nums[i - 1] {
                stack.pop();
            }
            let j = stack[stack.len() - 1];
            dp[i] = (dp[j] + (i - j) as i64 * nums[i - 1] as i64) % MOD;
            stack.push(i);
        }
        let mut ans = 0i64;
        for &x in &dp[1..=n] {
            ans = (ans + x) % MOD;
        }
        ans as i32
    }
}