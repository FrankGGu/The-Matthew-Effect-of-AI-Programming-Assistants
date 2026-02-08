impl Solution {
    pub fn detect_capital(word: String) -> bool {
        let n = word.len();
        if n == 0 {
            return true;
        }

        let mut uppercase_count = 0;
        for c in word.chars() {
            if c.is_uppercase() {
                uppercase_count += 1;
            }
        }

        if uppercase_count == n {
            // All letters are capitals (e.g., "USA")
            true
        } else if uppercase_count == 0 {
            // All letters are not capitals (e.g., "leetcode")
            true
        } else if uppercase_count == 1 && word.chars().next().unwrap().is_uppercase() {
            // Only the first letter in the word is a capital (e.g., "Google")
            true
        } else {
            false
        }
    }
}