impl Solution {
    pub fn remove_kdigits(num: String, k: i32) -> String {
        let mut stack: Vec<char> = Vec::new();
        let mut k_remaining = k;

        for c in num.chars() {
            while !stack.is_empty() && k_remaining > 0 && *stack.last().unwrap() > c {
                stack.pop();
                k_remaining -= 1;
            }
            stack.push(c);
        }

        while k_remaining > 0 {
            stack.pop();
            k_remaining -= 1;
        }

        let mut result: String = stack.into_iter().collect();
        while result.len() > 1 && result.starts_with('0') {
            result.remove(0);
        }

        if result.is_empty() {
            return "0".to_string();
        }

        result
    }
}