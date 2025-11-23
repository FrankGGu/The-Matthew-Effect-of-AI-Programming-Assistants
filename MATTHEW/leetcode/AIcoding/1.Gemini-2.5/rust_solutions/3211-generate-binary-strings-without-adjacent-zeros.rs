struct Solution;

impl Solution {
    pub fn generate_binary_strings(n: i32) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        let mut current_string: String = String::with_capacity(n as usize);

        let mut backtrack = |mut k: i32, n: i32, current_string: &mut String, result: &mut Vec<String>| {
            if k == n {
                result.push(current_string.clone());
                return;
            }

            // Option 1: Append '1'
            current_string.push('1');
            backtrack(k + 1, n, current_string, result);
            current_string.pop(); // Backtrack

            // Option 2: Append '0'
            // '0' can be appended if it's the first character (k == 0)
            // or if the previous character (at index k-1) was '1'.
            if current_string.is_empty() || current_string.chars().last().unwrap() == '1' {
                current_string.push('0');
                backtrack(k + 1, n, current_string, result);
                current_string.pop(); // Backtrack
            }
        };

        backtrack(0, n, &mut current_string, &mut result);
        result
    }
}