impl Solution {
    pub fn smallest_beautiful_string(s: String, k: i32) -> String {
        let mut s_bytes = s.into_bytes();
        let n = s_bytes.len();
        let k_u8 = k as u8;

        for i in (0..n).rev() {
            for c in (s_bytes[i] + 1)..('a' as u8 + k_u8) {
                if (i > 0 && s_bytes[i - 1] == c) || (i > 1 && s_bytes[i - 2] == c) {
                    continue;
                }

                s_bytes[i] = c;

                for j in (i + 1)..n {
                    for next_c in 'a' as u8..('a' as u8 + k_u8) {
                        if (j > 0 && s_bytes[j - 1] == next_c) || (j > 1 && s_bytes[j - 2] == next_c) {
                            continue;
                        }
                        s_bytes[j] = next_c;
                        break;
                    }
                }

                return String::from_utf8(s_bytes).unwrap();
            }
        }

        "".to_string()
    }
}