impl Solution {
    pub fn construct_smallest_number(pattern: String) -> String {
        let n = pattern.len();
        let mut result_chars: Vec<char> = Vec::with_capacity(n + 1);
        let mut stack: Vec<char> = Vec::with_capacity(n + 1);

        for i in 0..=n {
            stack.push(std::char::from_digit((i + 1) as u32, 10).unwrap());

            if i == n || pattern.as_bytes()[i] == b'I' {
                while let Some(c) = stack.pop() {
                    result_chars.push(c);
                }
            }
        }

        result_chars.into_iter().collect()
    }
}