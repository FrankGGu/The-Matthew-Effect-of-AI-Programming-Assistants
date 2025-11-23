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

        for len in 1..=3 {
            if start + len > s.len() { break; }
            let segment = &s[start..start + len];
            if (len == 1) || (len == 2 && segment.as_bytes()[0] != b'0') || (len == 3 && segment.parse::<u32>().unwrap() <= 255) {
                path.push(segment.to_string());
                Self::backtrack(s, start + len, path, res);
                path.pop();
            }
        }
    }
}