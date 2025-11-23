impl Solution {
    pub fn transformed_string_length(s: String, transformations: Vec<char>) -> i32 {
        let mut count = 0;
        for c in s.chars() {
            if transformations.contains(&c) {
                count += 2;
            } else {
                count += 1;
            }
        }
        count
    }
}