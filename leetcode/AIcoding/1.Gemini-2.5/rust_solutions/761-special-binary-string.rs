struct Solution;

impl Solution {
    pub fn make_largest_special(s: String) -> String {
        let n = s.len();
        if n == 0 {
            return "".to_string();
        }

        let mut res: Vec<String> = Vec::new();
        let mut balance = 0;
        let mut start = 0;

        for i in 0..n {
            if s.as_bytes()[i] == b'1' {
                balance += 1;
            } else {
                balance -= 1;
            }

            if balance == 0 {
                let inner_string_slice = &s[start + 1..i];
                let processed_inner = Self::make_largest_special(inner_string_slice.to_string());

                let mut current_special = String::with_capacity(processed_inner.len() + 2);
                current_special.push('1');
                current_special.push_str(&processed_inner);
                current_special.push('0');

                res.push(current_special);
                start = i + 1;
            }
        }

        res.sort_by(|a, b| b.cmp(a));
        res.join("")
    }
}