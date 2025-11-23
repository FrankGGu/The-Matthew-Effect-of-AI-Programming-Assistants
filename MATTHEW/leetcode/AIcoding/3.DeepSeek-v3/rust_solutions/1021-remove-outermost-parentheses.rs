impl Solution {
    pub fn remove_outer_parentheses(s: String) -> String {
        let mut result = String::new();
        let mut balance = 0;
        let mut start = 0;

        for (i, c) in s.chars().enumerate() {
            if c == '(' {
                balance += 1;
            } else {
                balance -= 1;
            }

            if balance == 0 {
                result.push_str(&s[start + 1..i]);
                start = i + 1;
            }
        }

        result
    }
}