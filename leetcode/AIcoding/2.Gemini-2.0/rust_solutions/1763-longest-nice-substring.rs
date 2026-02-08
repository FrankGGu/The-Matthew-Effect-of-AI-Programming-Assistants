impl Solution {
    pub fn longest_nice_substring(s: String) -> String {
        if s.is_empty() {
            return String::new();
        }

        let bytes = s.as_bytes();
        let n = bytes.len();
        let mut max_len = 0;
        let mut max_start = 0;

        for i in 0..n {
            for j in i + 1..=n {
                let sub = &s[i..j];
                if Self::is_nice(sub) {
                    let len = j - i;
                    if len > max_len {
                        max_len = len;
                        max_start = i;
                    }
                }
            }
        }

        s[max_start..max_start + max_len].to_string()
    }

    fn is_nice(s: &str) -> bool {
        let mut lower = 0u32;
        let mut upper = 0u32;

        for &b in s.as_bytes() {
            if b >= b'a' && b <= b'z' {
                lower |= 1 << (b - b'a');
            } else if b >= b'A' && b <= b'Z' {
                upper |= 1 << (b - b'A');
            }
        }

        lower == upper
    }
}