impl Solution {
    pub fn best_closing_time(customers: String) -> i32 {
        let chars: Vec<char> = customers.chars().collect();
        let n = chars.len();
        let mut prefix_n = vec![0; n + 1];
        let mut prefix_y = vec![0; n + 1];

        for i in 0..n {
            prefix_n[i + 1] = prefix_n[i] + if chars[i] == 'N' { 1 } else { 0 };
            prefix_y[i + 1] = prefix_y[i] + if chars[i] == 'Y' { 1 } else { 0 };
        }

        let mut min_penalty = i32::MAX;
        let mut best_hour = 0;

        for hour in 0..=n {
            let penalty = prefix_n[hour] + (prefix_y[n] - prefix_y[hour]);
            if penalty < min_penalty {
                min_penalty = penalty;
                best_hour = hour;
            }
        }

        best_hour as i32
    }
}