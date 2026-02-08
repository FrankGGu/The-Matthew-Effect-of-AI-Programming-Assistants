impl Solution {
    pub fn letter_combinations(digits: String) -> Vec<String> {
        if digits.is_empty() {
            return vec![];
        }

        let mapping: std::collections::HashMap<char, Vec<char>> = [
            ('2', vec!['a', 'b', 'c']),
            ('3', vec!['d', 'e', 'f']),
            ('4', vec!['g', 'h', 'i']),
            ('5', vec!['j', 'k', 'l']),
            ('6', vec!['m', 'n', 'o']),
            ('7', vec!['p', 'q', 'r', 's']),
            ('8', vec!['t', 'u', 'v']),
            ('9', vec!['w', 'x', 'y', 'z']),
        ]
        .iter()
        .cloned()
        .collect();

        let mut result: Vec<String> = vec![];
        let mut combination: String = String::new();

        fn backtrack(
            digits: &String,
            index: usize,
            combination: &mut String,
            result: &mut Vec<String>,
            mapping: &std::collections::HashMap<char, Vec<char>>,
        ) {
            if index == digits.len() {
                result.push(combination.clone());
                return;
            }

            let digit = digits.chars().nth(index).unwrap();
            if let Some(letters) = mapping.get(&digit) {
                for &letter in letters {
                    combination.push(letter);
                    backtrack(digits, index + 1, combination, result, mapping);
                    combination.pop();
                }
            }
        }

        backtrack(&digits, 0, &mut combination, &mut result, &mapping);

        result
    }
}