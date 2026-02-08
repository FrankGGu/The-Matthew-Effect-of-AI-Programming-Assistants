impl Solution {
    pub fn letter_case_permutation(s: String) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        let chars: Vec<char> = s.chars().collect();
        let mut current_permutation: Vec<char> = Vec::new();

        Self::backtrack(&chars, 0, &mut current_permutation, &mut result);

        result
    }

    fn backtrack(
        original_chars: &Vec<char>,
        index: usize,
        current_permutation: &mut Vec<char>,
        result: &mut Vec<String>,
    ) {
        if index == original_chars.len() {
            result.push(current_permutation.iter().collect());
            return;
        }

        let char_at_index = original_chars[index];

        if char_at_index.is_ascii_digit() {
            current_permutation.push(char_at_index);
            Self::backtrack(original_chars, index + 1, current_permutation, result);
            current_permutation.pop();
        } else {
            current_permutation.push(char_at_index.to_ascii_lowercase());
            Self::backtrack(original_chars, index + 1, current_permutation, result);
            current_permutation.pop();

            current_permutation.push(char_at_index.to_ascii_uppercase());
            Self::backtrack(original_chars, index + 1, current_permutation, result);
            current_permutation.pop();
        }
    }
}