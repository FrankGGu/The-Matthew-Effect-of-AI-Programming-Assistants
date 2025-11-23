impl Solution {
    pub fn letter_combinations(digits: String) -> Vec<String> {
        let keypad: Vec<&str> = vec[
            "", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"
        ];

        let mut result = Vec::new();

        if digits.is_empty() {
            return result;
        }

        fn backtrack(combination: &mut String, next_digits: &str, keypad: &Vec<&str>, result: &mut Vec<String>) {
            if next_digits.is_empty() {
                result.push(combination.clone());
            } else {
                let digit = next_digits.chars().next().unwrap();
                let letters = keypad[digit.to_digit(10).unwrap() as usize];

                for letter in letters.chars() {
                    combination.push(letter);
                    backtrack(combination, &next_digits[1..], keypad, result);
                    combination.pop();
                }
            }
        }

        backtrack(&mut String::new(), &digits, &keypad, &mut result);
        result
    }
}