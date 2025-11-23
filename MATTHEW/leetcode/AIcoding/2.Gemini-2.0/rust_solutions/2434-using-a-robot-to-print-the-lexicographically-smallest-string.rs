impl Solution {
    pub fn robot_with_string(s: String) -> String {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut suffix_min = vec![b'z' + 1; n + 1];
        for i in (0..n).rev() {
            suffix_min[i] = std::cmp::min(suffix_min[i + 1], s_bytes[i]);
        }

        let mut stack: Vec<u8> = Vec::new();
        let mut result = String::new();

        for i in 0..n {
            stack.push(s_bytes[i]);

            while !stack.is_empty() && *stack.last().unwrap() <= suffix_min[i + 1] {
                result.push(stack.pop().unwrap() as char);
            }
        }

        while !stack.is_empty() {
            result.push(stack.pop().unwrap() as char);
        }

        result
    }
}