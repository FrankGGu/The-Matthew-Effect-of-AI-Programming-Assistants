impl Solution {
    pub fn generate_binary_strings(n: i32) -> Vec<String> {
        fn backtrack(n: i32, s: String, last_was_zero: bool, result: &mut Vec<String>) {
            if s.len() as i32 == n {
                result.push(s);
                return;
            }
            backtrack(n, s.clone() + "1", false, result);
            if !last_was_zero {
                backtrack(n, s + "0", true, result);
            }
        }
        let mut result = Vec::new();
        backtrack(n, String::new(), false, &mut result);
        result
    }
}