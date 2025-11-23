impl Solution {
    pub fn generate_parenthesis(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        Self::backtrack(&mut result, String::new(), 0, 0, n);
        result
    }

    fn backtrack(result: &mut Vec<String>, current: String, open: i32, close: i32, max: i32) {
        if current.len() as i32 == max * 2 {
            result.push(current);
            return;
        }

        if open < max {
            let mut new_current = current.clone();
            new_current.push('(');
            Self::backtrack(result, new_current, open + 1, close, max);
        }

        if close < open {
            let mut new_current = current.clone();
            new_current.push(')');
            Self::backtrack(result, new_current, open, close + 1, max);
        }
    }
}