impl Solution {
    pub fn count_the_number_of_special_characters(s: String) -> i32 {
        let mut count = 0;
        let mut seen = std::collections::HashSet::new();
        for c in s.chars() {
            if !c.is_alphanumeric() && seen.insert(c) {
                count += 1;
            }
        }
        count
    }
}