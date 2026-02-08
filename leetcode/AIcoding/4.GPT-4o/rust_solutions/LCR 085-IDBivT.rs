impl Solution {
    pub fn generate_parenthesis(n: i32) -> Vec<String> {
        fn backtrack(current: String, open: i32, close: i32, max: i32, result: &mut Vec<String>) {
            if current.len() as i32 == max * 2 {
                result.push(current);
                return;
            }
            if open < max {
                backtrack(current.clone() + "(", open + 1, close, max, result);
            }
            if close < open {
                backtrack(current.clone() + ")", open, close + 1, max, result);
            }
        }
        let mut result = Vec::new();
        backtrack(String::new(), 0, 0, n, &mut result);
        result
    }
}