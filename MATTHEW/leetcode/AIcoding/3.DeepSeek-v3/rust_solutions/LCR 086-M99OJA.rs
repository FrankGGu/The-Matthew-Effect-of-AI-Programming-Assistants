impl Solution {
    pub fn partition(s: String) -> Vec<Vec<String>> {
        let mut res = Vec::new();
        let mut path = Vec::new();
        let s_chars: Vec<char> = s.chars().collect();
        Self::backtrack(&s_chars, 0, &mut path, &mut res);
        res
    }

    fn backtrack(s: &[char], start: usize, path: &mut Vec<String>, res: &mut Vec<Vec<String>>) {
        if start == s.len() {
            res.push(path.clone());
            return;
        }
        for end in start..s.len() {
            if Self::is_palindrome(s, start, end) {
                let substring: String = s[start..=end].iter().collect();
                path.push(substring);
                Self::backtrack(s, end + 1, path, res);
                path.pop();
            }
        }
    }

    fn is_palindrome(s: &[char], mut left: usize, mut right: usize) -> bool {
        while left < right {
            if s[left] != s[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}