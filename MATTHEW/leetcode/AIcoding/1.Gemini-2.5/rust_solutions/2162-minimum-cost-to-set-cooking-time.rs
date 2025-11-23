impl Solution {
    fn calculate_cost(m: i32, s: i32, start_at: i32, move_cost: i32, push_cost: i32) -> i32 {
        let s_mm = format!("{:02}", m);
        let s_ss = format!("{:02}", s);
        let full_str = s_mm + &s_ss;

        let digits_str = full_str.trim_start_matches('0');
        let effective_digits = if digits_str.is_empty() { "0" } else { digits_str };

        let mut current_digit = start_at;
        let mut total_cost = 0;

        for c in effective_digits.chars() {
            let digit = c.to_digit(10).unwrap() as i32;
            if digit != current_digit {
                total_cost += move_cost;
            }
            total_cost += push_cost;
            current_digit = digit;
        }
        total_cost
    }

    pub fn min_cost_set_cooking_time(target_seconds: i32, start_at: i32, move_cost: i32, push_cost: i32) -> i32 {
        let mut min_total_cost = i32::MAX;

        // Candidate 1: M = targetSeconds / 60, S = targetSeconds % 60
        let m1 = target_seconds / 60;
        let s1 = target_seconds % 60;

        // Check if M is within the valid range [0, 99]
        if m1 <= 99 {
            min_total_cost = min_total_cost.min(Self::calculate_cost(m1, s1, start_at, move_cost, push_cost));
        }

        // Candidate 2: M = targetSeconds / 60 - 1, S = targetSeconds % 60 + 60
        // This is only possible if targetSeconds is at least 60
        if target_seconds >= 60 {
            let m2 = m1 - 1;
            let s2 = s1 + 60;

            // Check if M is non-negative and S is within the valid range [0, 99]
            // m2 will always be >= 0 if target_seconds >= 60 (since m1 >= 1)
            if s2 <= 99 {
                min_total_cost = min_total_cost.min(Self::calculate_cost(m2, s2, start_at, move_cost, push_cost));
            }
        }

        min_total_cost
    }
}