impl Solution {
    pub fn count_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let sum: i64 = nums.iter().map(|&x| x as i64).sum();
        if sum % 2 != 0 {
            return 0;
        }

        let target = (sum / 2) as i32;
        let n = nums.len();
        let mut dp = vec![0; target as usize + 1];
        dp[0] = 1;

        for &num in &nums {
            for j in (num..=target).rev() {
                dp[j as usize] = (dp[j as usize] + dp[(j - num) as usize]) % 1000000007;
            }
        }

        let mut ans = dp[target as usize] as i64;
        for _ in 0..n {
            ans = (ans * 2) % 1000000007;
        }

        for &num in &nums {
            if num > k {
                ans = (ans - 1 + 1000000007) % 1000000007;
            }
        }

        (ans % 1000000007) as i32
    }
}