impl Solution {
    pub fn letter_combinations(digits: String) -> Vec<String> {
        if digits.is_empty() {
            return vec![];
        }

        let digit_to_letters: std::collections::HashMap<char, &str> = [
            ('2', "abc"),
            ('3', "def"),
            ('4', "ghi"),
            ('5', "jkl"),
            ('6', "mno"),
            ('7', "pqrs"),
            ('8', "tuv"),
            ('9', "wxyz"),
        ].iter().cloned().collect();

        let mut result = vec![String::new()];

        for digit in digits.chars() {
            let letters = digit_to_letters[&digit].chars();
            let mut temp = Vec::new();
            for combination in result {
                for letter in letters.clone() {
                    let mut new_combination = combination.clone();
                    new_combination.push(letter);
                    temp.push(new_combination);
                }
            }
            result = temp;
        }

        result
    }
}