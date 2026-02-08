impl Solution {
    pub fn letter_case_permutation(s: String) -> Vec<String> {
        let mut res: Vec<String> = Vec::new();
        let mut chars: Vec<char> = s.chars().collect();

        fn backtrack(chars: &mut Vec<char>, index: usize, res: &mut Vec<String>) {
            if index == chars.len() {
                res.push(chars.iter().collect());
                return;
            }

            if chars[index].is_alphabetic() {
                let original_char = chars[index];

                chars[index] = chars[index].to_lowercase().next().unwrap();
                backtrack(chars, index + 1, res);

                chars[index] = chars[index].to_uppercase().next().unwrap();
                backtrack(chars, index + 1, res);

                chars[index] = original_char;
            } else {
                backtrack(chars, index + 1, res);
            }
        }

        backtrack(&mut chars, 0, &mut res);
        res
    }
}