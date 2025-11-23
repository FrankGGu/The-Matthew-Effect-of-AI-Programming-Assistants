impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        let mut result = Vec::new();
        let n = s.len();

        fn backtrack(s: &String, start: usize, dots: i32, current_ip: &mut String, result: &mut Vec<String>) {
            if dots == 4 {
                if start == s.len() {
                    result.push(current_ip.clone());
                }
                return;
            }

            for i in 1..=3 {
                if start + i > s.len() {
                    break;
                }

                let segment = &s[start..start + i];
                if (segment.len() > 1 && segment.starts_with("0")) || (segment.parse::<i32>().unwrap() > 255) {
                    continue;
                }

                let original_len = current_ip.len();
                if dots > 0 {
                    current_ip.push('.');
                }
                current_ip.push_str(segment);

                backtrack(s, start + i, dots + 1, current_ip, result);

                current_ip.truncate(original_len);
            }
        }

        let mut current_ip = String::new();
        backtrack(&s, 0, 0, &mut current_ip, &mut result);

        result
    }
}