impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        let mut res = Vec::new();
        let n = s.len();

        fn backtrack(s: &str, start: usize, dots: i32, current_ip: &mut String, res: &mut Vec<String>) {
            if dots == 4 {
                if start == s.len() {
                    res.push(current_ip.clone());
                }
                return;
            }

            for i in start..std::cmp::min(start + 3, s.len()) {
                let segment = &s[start..=i];
                if segment.len() > 1 && segment.starts_with('0') {
                    continue;
                }
                if let Ok(num) = segment.parse::<i32>() {
                    if num >= 0 && num <= 255 {
                        let original_len = current_ip.len();
                        if dots > 0 {
                            current_ip.push('.');
                        }
                        current_ip.push_str(segment);

                        backtrack(s, i + 1, dots + 1, current_ip, res);

                        current_ip.truncate(original_len);
                    }
                }
            }
        }

        let mut current_ip = String::new();
        backtrack(&s, 0, 0, &mut current_ip, &mut res);

        res
    }
}