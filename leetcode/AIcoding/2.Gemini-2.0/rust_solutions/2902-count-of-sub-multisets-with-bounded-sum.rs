impl Solution {
    pub fn count_sub_multisets(nums: Vec<i32>, l: i32, r: i32) -> i32 {
        let mut counts = std::collections::HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut dp = vec![0; (r + 1) as usize];
        dp[0] = 1;

        for (&num, &count) in &counts {
            if num > r {
                continue;
            }
            let mut new_dp = dp.clone();
            for i in 1..=count {
                if num as i64 * i as i64 > r as i64 {
                    break;
                }
                for j in num as usize * i as usize..=(r as usize) {
                    new_dp[j] = (new_dp[j] + dp[j - num as usize * i as usize]) % 1_000_000_007;
                }
            }
            dp = new_dp;
        }

        let mut ans = 0;
        for i in l as usize..=(r as usize) {
            ans = (ans + dp[i]) % 1_000_000_007;
        }

        ans
    }
}