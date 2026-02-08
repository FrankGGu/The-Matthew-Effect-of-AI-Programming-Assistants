impl Solution {
    pub fn smallest_string(s: String, k: i32) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        if k == 0 {
            return s;
        }

        let n = chars.len();
        let mut start = 0;

        while start < n && chars[start] == 'a' {
            start += 1;
        }

        if start < n {
            if k > 0 {
                for i in start..n {
                    if chars[i] > 'a' {
                        chars[i] = (chars[i] as u8 - 1) as char;
                        if chars[i] == 'a' {
                            break;
                        }
                    }
                }
            }
        }

        chars.iter().collect()
    }
}