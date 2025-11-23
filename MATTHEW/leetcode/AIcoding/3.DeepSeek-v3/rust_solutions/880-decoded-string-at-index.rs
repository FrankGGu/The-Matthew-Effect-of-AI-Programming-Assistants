impl Solution {
    pub fn decode_at_index(s: String, k: i32) -> String {
        let mut size: u64 = 0;
        let s_bytes = s.as_bytes();
        let mut k = k as u64;

        for &c in s_bytes.iter() {
            if c.is_ascii_digit() {
                size *= (c - b'0') as u64;
            } else {
                size += 1;
            }
        }

        for &c in s_bytes.iter().rev() {
            k %= size;
            if k == 0 && c.is_ascii_alphabetic() {
                return (c as char).to_string();
            }

            if c.is_ascii_digit() {
                size /= (c - b'0') as u64;
            } else {
                size -= 1;
            }
        }

        String::new()
    }
}