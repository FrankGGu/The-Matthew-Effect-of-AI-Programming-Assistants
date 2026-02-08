impl Solution {
    pub fn count_substrings(s: String, t: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let mut count = 0;

        for i in 0..s_chars.len() {
            for j in i..s_chars.len() {
                let len = j - i + 1;
                if len != t_chars.len() {
                    continue;
                }
                let mut diff = 0;
                for k in 0..len {
                    if s_chars[i + k] != t_chars[k] {
                        diff += 1;
                        if diff > 1 {
                            break;
                        }
                    }
                }
                if diff == 1 {
                    count += 1;
                }
            }
        }

        count
    }
}