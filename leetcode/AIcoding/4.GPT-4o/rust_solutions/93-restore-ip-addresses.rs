impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        fn backtrack(start: usize, path: Vec<String>, result: &mut Vec<String>, s: &str) {
            if path.len() == 4 {
                if start == s.len() {
                    result.push(path.join("."));
                }
                return;
            }
            for len in 1..=3 {
                if start + len <= s.len() {
                    let segment = &s[start..start + len];
                    if (len == 1 || (segment.as_bytes()[0] != b'0' && segment.parse::<u8>().is_ok())) && segment.len() <= 3 {
                        backtrack(start + len, [path.clone(), vec![segment.to_string()]].concat(), result, s);
                    }
                }
            }
        }

        let mut result = Vec::new();
        backtrack(0, Vec::new(), &mut result, &s);
        result
    }
}