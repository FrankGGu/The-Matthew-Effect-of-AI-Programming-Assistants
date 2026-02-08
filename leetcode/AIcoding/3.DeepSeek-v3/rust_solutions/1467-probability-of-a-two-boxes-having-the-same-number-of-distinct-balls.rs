impl Solution {
    pub fn get_probability(balls: Vec<i32>) -> f64 {
        let total: i32 = balls.iter().sum();
        let half = total / 2;
        let mut fact = vec![1.0; (total + 1) as usize];
        for i in 1..=total as usize {
            fact[i] = fact[i - 1] * i as f64;
        }

        let mut res = 0.0;
        let mut dp = vec![vec![0.0; balls.len() + 1]; (half + 1) as usize];
        dp[0][0] = 1.0;
        let mut sum = 0;

        for (k, &cnt) in balls.iter().enumerate() {
            sum += cnt;
            for i in (0..=half).rev() {
                for j in (0..=k).rev() {
                    if dp[i as usize][j] == 0.0 {
                        continue;
                    }
                    for take in 1..=cnt {
                        if i + take > half {
                            break;
                        }
                        let ways = fact[cnt as usize] / (fact[take as usize] * fact[(cnt - take) as usize]);
                        dp[(i + take) as usize][j + 1] += dp[i as usize][j] * ways;
                    }
                }
            }
        }

        let valid = dp[half as usize][balls.len() / 2];
        let total_ways = fact[total as usize] / balls.iter().fold(1.0, |acc, &x| acc * fact[x as usize]);

        valid / total_ways
    }
}