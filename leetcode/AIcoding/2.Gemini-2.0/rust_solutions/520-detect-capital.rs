impl Solution {
    pub fn detect_capital_use(word: String) -> bool {
        let n = word.len();
        if n == 0 {
            return true;
        }

        let mut upper_count = 0;
        for c in word.chars() {
            if c.is_uppercase() {
                upper_count += 1;
            }
        }

        if upper_count == n {
            return true;
        }

        if upper_count == 0 {
            return true;
        }

        if upper_count == 1 && word.chars().nth(0).unwrap().is_uppercase() {
            return true;
        }

        return false;
    }
}