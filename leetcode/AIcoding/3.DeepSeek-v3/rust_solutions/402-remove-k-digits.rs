impl Solution {
    pub fn remove_kdigits(num: String, k: i32) -> String {
        let mut k = k as usize;
        let mut stack = Vec::new();

        for ch in num.chars() {
            while k > 0 && !stack.is_empty() && stack.last().unwrap() > &ch {
                stack.pop();
                k -= 1;
            }
            stack.push(ch);
        }

        while k > 0 {
            stack.pop();
            k -= 1;
        }

        let result: String = stack.into_iter().collect();
        let trimmed = result.trim_start_matches('0');

        if trimmed.is_empty() {
            "0".to_string()
        } else {
            trimmed.to_string()
        }
    }
}