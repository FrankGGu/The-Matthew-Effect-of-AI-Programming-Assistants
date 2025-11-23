impl Solution {
    pub fn split_string(s: String) -> bool {
        fn backtrack(s: &str, prev: i64) -> bool {
            if s.is_empty() {
                return true;
            }

            for i in 1..=s.len() {
                if let Ok(num) = s[..i].parse::<i64>() {
                    if prev == -1 || prev - num == 1 {
                        if backtrack(&s[i..], num) {
                            return true;
                        }
                    }
                }
            }

            false
        }

        for i in 1..=s.len() {
            if let Ok(num) = s[..i].parse::<i64>() {
                if backtrack(&s[i..], num) {
                    return true;
                }
            }
        }

        false
    }
}