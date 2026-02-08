impl Solution {
    pub fn partition(s: String) -> Vec<Vec<String>> {
        let mut result = Vec::new();
        let mut path = Vec::new();
        Self::backtrack(&s, 0, &mut path, &mut result);
        result
    }

    fn backtrack(s: &str, start: usize, path: &mut Vec<String>, result: &mut Vec<Vec<String>>) {
        if start == s.len() {
            result.push(path.clone());
            return;
        }
        for end in start + 1..=s.len() {
            let substring = &s[start..end];
            if Self::is_palindrome(substring) {
                path.push(substring.to_string());
                Self::backtrack(s, end, path, result);
                path.pop();
            }
        }
    }

    fn is_palindrome(s: &str) -> bool {
        s == s.chars().rev().collect::<String>().as_str()
    }
}