struct Solution;

impl Solution {
    pub fn generate_parenthesis(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        let mut current_combination = String::new();

        Self::backtrack(&mut result, &mut current_combination, 0, 0, n);

        result
    }

    fn backtrack(
        result: &mut Vec<String>,
        current_combination: &mut String,
        open_count: i32,
        close_count: i32,
        max_n: i32,
    ) {
        if current_combination.len() as i32 == 2 * max_n {
            result.push(current_combination.clone());
            return;
        }

        if open_count < max_n {
            current_combination.push('(');
            Self::backtrack(result, current_combination, open_count + 1, close_count, max_n);
            current_combination.pop();
        }

        if close_count < open_count {
            current_combination.push(')');
            Self::backtrack(result, current_combination, open_count, close_count + 1, max_n);
            current_combination.pop();
        }
    }
}