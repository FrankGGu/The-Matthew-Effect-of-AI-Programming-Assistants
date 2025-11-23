impl Solution {
    pub fn smallest_number(pattern: String) -> String {
        let n = pattern.len();
        let mut result = Vec::new();
        let mut stack = Vec::new();

        for i in 0..=n {
            stack.push((i + 1).to_string());
            if i == n || pattern.as_bytes()[i] == b'I' {
                while let Some(num) = stack.pop() {
                    result.push(num);
                }
            }
        }

        result.concat()
    }
}