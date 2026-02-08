impl Solution {
    pub fn decode_at_index(s: String, k: i32) -> String {
        let mut size: i64 = 0;
        let chars: Vec<char> = s.chars().collect();
        for &c in &chars {
            if c.is_digit(10) {
                size *= c.to_digit(10).unwrap() as i64;
            } else {
                size += 1;
            }
        }

        let mut k = k as i64;

        for i in (0..chars.len()).rev() {
            let c = chars[i];
            k %= size;

            if k == 0 && !c.is_digit(10) {
                return c.to_string();
            }

            if c.is_digit(10) {
                size /= c.to_digit(10).unwrap() as i64;
            } else {
                size -= 1;
            }
        }

        "".to_string()
    }
}