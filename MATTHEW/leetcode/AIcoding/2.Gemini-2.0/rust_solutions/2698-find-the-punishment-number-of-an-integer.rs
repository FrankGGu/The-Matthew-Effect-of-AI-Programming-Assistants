impl Solution {
    pub fn punishment_number(n: i32) -> i32 {
        let mut sum = 0;
        for i in 1..=n {
            let square = i * i;
            let s = square.to_string();
            if Self::is_valid(&s, 0, 0, i) {
                sum += square;
            }
        }
        sum
    }

    fn is_valid(s: &str, start: usize, current_sum: i32, target: i32) -> bool {
        if start == s.len() {
            return current_sum == target;
        }

        for i in start..s.len() {
            let num_str = &s[start..=i];
            if let Ok(num) = num_str.parse::<i32>() {
                if Self::is_valid(s, i + 1, current_sum + num, target) {
                    return true;
                }
            }
        }

        false
    }
}