impl Solution {
    pub fn min_changes(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut freq = vec![std::collections::HashMap::new(); k];
        for i in 0..n {
            let count = freq[i % k].entry(nums[i]).or_insert(0);
            *count += 1;
        }

        let mut dp = vec![vec![n + 1; 1024]; k];
        let mut min_prev = vec![n + 1; k];

        for x in 0..1024 {
            let cnt = *freq[0].get(&x).unwrap_or(&0);
            dp[0][x] = n - cnt;
            min_prev[0] = min_prev[0].min(dp[0][x]);
        }

        for i in 1..k {
            for x in 0..1024 {
                dp[i][x] = min_prev[i - 1] + n;
                for (num, cnt) in &freq[i] {
                    let num = *num;
                    dp[i][x] = dp[i][x].min(dp[i - 1][x ^ num] + n - cnt);
                }
                min_prev[i] = min_prev[i].min(dp[i][x]);
            }
        }

        dp[k - 1][0] as i32
    }
}