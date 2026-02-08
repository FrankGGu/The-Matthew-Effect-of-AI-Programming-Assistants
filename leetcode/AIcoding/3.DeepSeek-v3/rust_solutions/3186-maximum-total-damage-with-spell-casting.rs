use std::collections::HashMap;

impl Solution {
    pub fn maximum_total_damage(power: Vec<i32>) -> i64 {
        let mut freq = HashMap::new();
        for &p in &power {
            *freq.entry(p).or_insert(0) += 1;
        }
        let mut unique_powers: Vec<i32> = freq.keys().cloned().collect();
        unique_powers.sort_unstable();

        let n = unique_powers.len();
        let mut dp = vec![0; n + 1];

        for i in (0..n).rev() {
            let p = unique_powers[i];
            let count = *freq.get(&p).unwrap() as i64;
            let total = p as i64 * count;

            let mut next = i + 1;
            while next < n && (unique_powers[next] == p + 1 || unique_powers[next] == p + 2) {
                next += 1;
            }

            if next < n {
                dp[i] = (total + dp[next]).max(dp[i + 1]);
            } else {
                dp[i] = total.max(dp[i + 1]);
            }
        }

        dp[0]
    }
}