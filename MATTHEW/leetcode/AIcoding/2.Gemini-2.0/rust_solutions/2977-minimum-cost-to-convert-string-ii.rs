impl Solution {
    pub fn minimum_cost(s: String, target: String, changing_costs: Vec<String>, change_values: Vec<i32>) -> i64 {
        let n = s.len();
        let m = target.len();
        let s_bytes = s.as_bytes();
        let target_bytes = target.as_bytes();
        let mut costs = std::collections::HashMap::new();
        for i in 0..changing_costs.len() {
            costs.insert(changing_costs[i].clone(), change_values[i] as i64);
        }

        let mut dp = vec![i64::MAX; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            dp[i] = dp[i - 1] + (i64::from(target_bytes[i - 1] != s_bytes[i - 1]));
            for j in 0..i {
                let sub = String::from_utf8(s_bytes[j..i].to_vec()).unwrap();
                let target_sub = String::from_utf8(target_bytes[j..i].to_vec()).unwrap();
                if costs.contains_key(&sub) && costs.get(&sub).unwrap() >= &0 && sub.len() == target_sub.len() {
                    dp[i] = dp[i].min(dp[j] + costs.get(&sub).unwrap());
                }
            }
        }

        if dp[n] >= i64::MAX {
            return -1;
        }

        dp[n]
    }
}