struct Solution;

impl Solution {
    pub fn generate_parenthesis(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        let mut current_combination = String::new();
        Self::backtrack(&mut result, &mut current_combination, 0, 0, n as usize);
        result
    }

    fn backtrack(
        result: &mut Vec<String>,
        current_combination: &mut String,
        open: usize,
        close: usize,
        max: usize,
    ) {
        if current_combination.len() == 2 * max {
            result.push(current_combination.clone());
            return;
        }

        if open < max {
            current_combination.push('(');
            Self::backtrack(result, current_combination, open + 1, close, max);
            current_combination.pop();
        }

        if close < open {
            current_combination.push(')');
            Self::backtrack(result, current_combination, open, close + 1, max);
            current_combination.pop();
        }
    }
}