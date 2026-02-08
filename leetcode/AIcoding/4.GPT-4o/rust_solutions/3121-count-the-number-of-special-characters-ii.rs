impl Solution {
    pub fn count_special_characters(s: String) -> i32 {
        s.chars().filter(|&c| !c.is_alphanumeric()).count() as i32
    }
}