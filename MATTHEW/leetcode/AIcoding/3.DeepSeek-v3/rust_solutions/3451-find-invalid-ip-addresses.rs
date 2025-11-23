impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        let mut res = Vec::new();
        let mut path = Vec::new();
        Self::backtrack(&s, 0, &mut path, &mut res);
        res
    }

    fn backtrack(s: &str, start: usize, path: &mut Vec<String>, res: &mut Vec<String>) {
        if path.len() == 4 {
            if start == s.len() {
                res.push(path.join("."));
            }
            return;
        }

        for i in 1..=3 {
            if start + i > s.len() {
                break;
            }
            let segment = &s[start..start + i];
            if (segment.starts_with('0') && segment.len() > 1) || (segment.parse::<i32>().unwrap() > 255) {
                continue;
            }
            path.push(segment.to_string());
            Self::backtrack(s, start + i, path, res);
            path.pop();
        }
    }
}