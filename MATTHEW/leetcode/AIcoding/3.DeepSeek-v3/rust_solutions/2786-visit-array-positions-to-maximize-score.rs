impl Solution {
    pub fn max_score(nums: Vec<i32>, x: i32) -> i64 {
        let mut dp = [i64::MIN, i64::MIN];
        dp[(nums[0] % 2) as usize] = nums[0] as i64;

        for &num in &nums[1..] {
            let parity = (num % 2) as usize;
            let other_parity = 1 - parity;
            let current = dp[parity].max(dp[other_parity] + if parity == other_parity { 0 } else { -x as i64 }) + num as i64;
            dp[parity] = dp[parity].max(current);
        }

        dp[0].max(dp[1])
    }
}