impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        let mut res = Vec::new();
        let mut path = Vec::new();

        fn backtrack(s: &String, index: usize, path: &mut Vec<String>, res: &mut Vec<String>) {
            if path.len() == 4 {
                if index == s.len() {
                    res.push(path.join("."));
                }
                return;
            }

            for i in 1..=3 {
                if index + i > s.len() {
                    break;
                }

                let sub = &s[index..index + i];
                if sub.len() > 1 && sub.starts_with("0") {
                    continue;
                }

                if let Ok(num) = sub.parse::<i32>() {
                    if num >= 0 && num <= 255 {
                        path.push(sub.to_string());
                        backtrack(s, index + i, path, res);
                        path.pop();
                    }
                }
            }
        }

        backtrack(&s, 0, &mut path, &mut res);
        res
    }
}