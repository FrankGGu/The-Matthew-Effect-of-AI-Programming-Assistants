impl Solution {
    pub fn letter_case_permutation(s: String) -> Vec<String> {
        let mut result = Vec::new();
        let mut chars: Vec<char> = s.chars().collect();
        Self::backtrack(&mut chars, 0, &mut result);
        result
    }

    fn backtrack(chars: &mut Vec<char>, index: usize, result: &mut Vec<String>) {
        if index == chars.len() {
            result.push(chars.iter().collect());
            return;
        }

        let c = chars[index];
        if c.is_alphabetic() {
            chars[index] = c.to_ascii_lowercase();
            Self::backtrack(chars, index + 1, result);

            chars[index] = c.to_ascii_uppercase();
            Self::backtrack(chars, index + 1, result);
        } else {
            Self::backtrack(chars, index + 1, result);
        }
    }
}