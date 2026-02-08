impl Solution {
    pub fn largest_number(cost: Vec<i32>, target: i32) -> String {
        let mut dp = vec![std::i32::MIN; (target + 1) as usize];
        dp[0] = 0;

        for t in 1..=target as usize {
            for digit_idx in 0..9 {
                let current_cost = cost[digit_idx];
                if t as i32 >= current_cost && dp[t - current_cost as usize] != std::i32::MIN {
                    dp[t] = dp[t].max(dp[t - current_cost as usize] + 1);
                }
            }
        }

        if dp[target as usize] == std::i32::MIN {
            return "0".to_string();
        }

        let mut result = String::new();
        let mut current_target = target;

        while current_target > 0 {
            for digit_val in (1..=9).rev() {
                let digit_idx = digit_val - 1;
                let current_cost = cost[digit_idx as usize];

                if current_target >= current_cost
                    && dp[(current_target - current_cost) as usize] != std::i32::MIN
                    && dp[(current_target - current_cost) as usize] + 1 == dp[current_target as usize]
                {
                    result.push_str(&digit_val.to_string());
                    current_target -= current_cost;
                    break;
                }
            }
        }

        result
    }
}