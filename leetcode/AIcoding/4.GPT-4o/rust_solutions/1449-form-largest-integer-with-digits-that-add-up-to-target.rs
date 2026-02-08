impl Solution {
    pub fn largest_integer(target: i32, digits: Vec<i32>) -> String {
        let mut dp = vec![""; target as usize + 1];
        dp[0] = String::new();

        for &digit in &digits {
            for j in (digit as usize..=target as usize).rev() {
                if dp[j - digit as usize].len() > 0 || j == digit as usize {
                    let new_number = format!("{}{}", dp[j - digit as usize], digit);
                    if new_number.len() > dp[j].len() || (new_number.len() == dp[j].len() && new_number > dp[j]) {
                        dp[j] = new_number;
                    }
                }
            }
        }

        dp[target as usize].clone()
    }
}