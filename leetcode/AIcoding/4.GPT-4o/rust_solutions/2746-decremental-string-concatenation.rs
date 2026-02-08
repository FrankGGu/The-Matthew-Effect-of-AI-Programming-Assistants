impl Solution {
    pub fn string_concatenation(n: i32) -> String {
        let mut result = String::new();
        for i in (1..=n).rev() {
            result.push_str(&i.to_string());
        }
        result
    }
}