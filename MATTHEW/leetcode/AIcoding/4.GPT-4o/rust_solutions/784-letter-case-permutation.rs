impl Solution {
    pub fn letter_case_permutation(s: String) -> Vec<String> {
        let mut result = vec![];
        let mut current = vec![];
        Self::backtrack(&s, 0, &mut current, &mut result);
        result
    }

    fn backtrack(s: &str, index: usize, current: &mut Vec<char>, result: &mut Vec<String>) {
        if index == s.len() {
            result.push(current.iter().collect());
            return;
        }
        current.push(s.chars().nth(index).unwrap());
        Self::backtrack(s, index + 1, current, result);
        current.pop();
        if s.chars().nth(index).unwrap().is_ascii_alphabetic() {
            let ch = s.chars().nth(index).unwrap().to_ascii_uppercase();
            current.push(ch);
            Self::backtrack(s, index + 1, current, result);
            current.pop();
        }
    }
}