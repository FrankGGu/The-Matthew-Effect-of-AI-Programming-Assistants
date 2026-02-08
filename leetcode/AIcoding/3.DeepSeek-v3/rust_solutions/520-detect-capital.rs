impl Solution {
    pub fn detect_capital_use(word: String) -> bool {
        let mut count = 0;
        let mut first_upper = false;
        let chars: Vec<char> = word.chars().collect();

        for (i, c) in chars.iter().enumerate() {
            if c.is_uppercase() {
                count += 1;
                if i == 0 {
                    first_upper = true;
                }
            }
        }

        count == 0 || count == chars.len() || (first_upper && count == 1)
    }
}