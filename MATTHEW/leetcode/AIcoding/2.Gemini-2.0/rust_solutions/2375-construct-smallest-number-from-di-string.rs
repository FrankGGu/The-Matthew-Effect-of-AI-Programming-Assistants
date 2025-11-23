impl Solution {
    pub fn smallest_number(pattern: String) -> String {
        let n = pattern.len();
        let mut result = String::new();
        let mut stack: Vec<i32> = Vec::new();
        let mut count = 1;

        for c in pattern.chars() {
            if c == 'I' {
                stack.push(count);
                count += 1;
                while !stack.is_empty() {
                    result.push_str(&stack.pop().unwrap().to_string());
                }
            } else {
                stack.push(count);
                count += 1;
            }
        }

        stack.push(count);
        while !stack.is_empty() {
            result.push_str(&stack.pop().unwrap().to_string());
        }

        result
    }
}