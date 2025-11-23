impl Solution {
    pub fn get_lex_smallest_string(s: String, k: i32) -> String {
        let k = k as u8;
        let mut s_bytes = s.into_bytes();
        let n = s_bytes.len();

        for i in 0..n {
            let current = s_bytes[i];
            let mut min_char = current;

            for d in 1..=k {
                let c = current.wrapping_sub(d);
                if c < min_char {
                    min_char = c;
                }
            }

            if min_char < current {
                s_bytes[i] = min_char;
                break;
            }
        }

        String::from_utf8(s_bytes).unwrap()
    }
}