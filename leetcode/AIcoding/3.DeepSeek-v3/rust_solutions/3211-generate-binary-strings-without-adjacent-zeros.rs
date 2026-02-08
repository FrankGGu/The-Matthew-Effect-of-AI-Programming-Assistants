impl Solution {
    pub fn generate_binary_strings(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        let mut current = String::new();
        Self::backtrack(n, &mut current, &mut result);
        result
    }

    fn backtrack(n: i32, current: &mut String, result: &mut Vec<String>) {
        if current.len() == n as usize {
            result.push(current.clone());
            return;
        }

        current.push('1');
        Self::backtrack(n, current, result);
        current.pop();

        if current.is_empty() || current.chars().last().unwrap() != '0' {
            current.push('0');
            Self::backtrack(n, current, result);
            current.pop();
        }
    }
}