impl Solution {
    pub fn letter_combinations(digits: String) -> Vec<String> {
        if digits.is_empty() {
            return vec![];
        }

        let mapping: Vec<&str> = vec![
            "",    // 0
            "",    // 1
            "abc", // 2
            "def", // 3
            "ghi", // 4
            "jkl", // 5
            "mno", // 6
            "pqrs",// 7
            "tuv", // 8
            "wxyz" // 9
        ];

        let mut result: Vec<String> = vec!["".to_string()];

        for digit_char in digits.chars() {
            let digit_val = digit_char.to_digit(10).unwrap() as usize;
            let letters = mapping[digit_val];

            let mut new_result: Vec<String> = Vec::new();

            for combination in result {
                for letter_char in letters.chars() {
                    let mut current_combo = combination.clone();
                    current_combo.push(letter_char);
                    new_result.push(current_combo);
                }
            }
            result = new_result;
        }

        result
    }
}