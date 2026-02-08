impl Solution {
    pub fn longest_special_substring(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s.len();
        let mut max_len = 0;

        for len in (1..=n / 3).rev() {
            let mut count = 0;
            let mut seen = std::collections::HashSet::new();
            for i in 0..=n - len {
                let mut is_special = true;
                for j in 1..len {
                    if s_bytes[i + j] != s_bytes[i] {
                        is_special = false;
                        break;
                    }
                }
                if is_special {
                    let sub = &s[i..i + len];
                    if !seen.contains(sub) {
                        count += 1;
                        seen.insert(sub.to_string());
                    }
                }
            }

            if count >= 3 {
                max_len = len as i32;
                break;
            }
        }

        max_len
    }
}