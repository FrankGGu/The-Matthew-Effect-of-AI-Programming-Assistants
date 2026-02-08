impl Solution {
    pub fn remove_k_digits(num: String, k: i32) -> String {
        let mut stack = Vec::new();
        let mut remaining = k;

        for digit in num.chars() {
            while remaining > 0 && !stack.is_empty() && *stack.last().unwrap() > digit {
                stack.pop();
                remaining -= 1;
            }
            stack.push(digit);
        }

        while remaining > 0 {
            stack.pop();
            remaining -= 1;
        }

        let result: String = stack.into_iter().collect();
        let trimmed_result = result.trim_start_matches('0');

        if trimmed_result.is_empty() {
            "0".to_string()
        } else {
            trimmed_result.to_string()
        }
    }
}