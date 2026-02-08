impl Solution {
    pub fn tallest_billboard(rods: Vec<i32>) -> i32 {
        let sum: i32 = rods.iter().sum();
        let mut dp = vec![-1; (sum + 1) as usize];
        dp[0] = 0;

        for &rod in rods.iter() {
            let mut curr = dp.clone();
            for i in 0..=sum {
                if dp[i as usize] == -1 {
                    continue;
                }
                let j = i + rod;
                if j <= sum {
                    curr[j as usize] = curr[j as usize].max(dp[i as usize]);
                }
                let k = (i - rod).abs();
                curr[k as usize] = curr[k as usize].max(dp[i as usize] + rod.min(i));
            }
            dp = curr;
        }

        dp[0]
    }
}