impl Solution {
    pub fn largest_number(cost: Vec<i32>, target: i32) -> String {
        let mut dp = vec!["".to_string(); target as usize + 1];
        dp[0] = "".to_string();

        for t in 1..=target as usize {
            for i in 0..cost.len() {
                if t as i32 >= cost[i] {
                    let prev_target = t as i32 - cost[i];
                    if dp[prev_target as usize] != "" || prev_target == 0 {
                        let new_num = format!("{}{}", dp[prev_target as usize], (i + 1).to_string());
                        if dp[t] == "" || new_num.len() > dp[t].len() || (new_num.len() == dp[t].len() && new_num > dp[t]) {
                            dp[t] = new_num;
                        }
                    }
                }
            }
        }

        if dp[target as usize] == "" {
            "0".to_string()
        } else {
            dp[target as usize].chars().collect::<Vec<_>>().sort_by(|a, b| b.cmp(a));
            dp[target as usize].chars().collect::<Vec<_>>().into_iter().collect::<String>()
        }
    }
}