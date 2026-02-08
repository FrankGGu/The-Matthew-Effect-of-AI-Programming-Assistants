impl Solution {
    pub fn max_value(n: String, x: i32) -> String {
        let x_char = (x as u8 + b'0') as char;
        let mut n_chars: Vec<char> = n.chars().collect();
        let is_negative = n_chars[0] == '-';

        let mut pos = 0;
        if is_negative {
            pos = 1;
            while pos < n_chars.len() && n_chars[pos] <= x_char {
                pos += 1;
            }
        } else {
            while pos < n_chars.len() && n_chars[pos] >= x_char {
                pos += 1;
            }
        }

        n_chars.insert(pos, x_char);
        n_chars.into_iter().collect()
    }
}