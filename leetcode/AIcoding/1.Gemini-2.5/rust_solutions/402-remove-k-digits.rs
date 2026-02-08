impl Solution {
    pub fn remove_kdigits(num: String, k: i32) -> String {
        let mut stack: Vec<char> = Vec::new();
        let mut k_removals = k;

        for digit in num.chars() {
            while k_removals > 0 && !stack.is_empty() && *stack.last().unwrap() > digit {
                stack.pop();
                k_removals -= 1;
            }
            stack.push(digit);
        }

        while k_removals > 0 && !stack.is_empty() {
            stack.pop();
            k_removals -= 1;
        }

        let mut result_str: String = stack.into_iter().collect();

        let trimmed = result_str.trim_start_matches('0');

        if trimmed.is_empty() {
            "0".to_string()
        } else {
            trimmed.to_string()
        }
    }
}