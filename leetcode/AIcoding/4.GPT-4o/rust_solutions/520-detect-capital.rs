impl Solution {
    pub fn detect_capital_use(word: String) -> bool {
        let is_all_upper = word.chars().all(|c| c.is_uppercase());
        let is_all_lower = word.chars().all(|c| c.is_lowercase());
        let is_first_upper_rest_lower = word.chars().next().unwrap().is_uppercase() && 
                                        word[1..].chars().all(|c| c.is_lowercase());

        is_all_upper || is_all_lower || is_first_upper_rest_lower
    }
}