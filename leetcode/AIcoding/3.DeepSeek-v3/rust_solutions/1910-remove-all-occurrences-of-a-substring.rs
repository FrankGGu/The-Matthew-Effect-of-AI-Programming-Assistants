impl Solution {
    pub fn remove_occurrences(s: String, part: String) -> String {
        let mut stack = Vec::new();
        let part_len = part.len();
        let part_chars: Vec<char> = part.chars().collect();

        for c in s.chars() {
            stack.push(c);
            if stack.len() >= part_len {
                let mut matched = true;
                for i in 0..part_len {
                    if stack[stack.len() - part_len + i] != part_chars[i] {
                        matched = false;
                        break;
                    }
                }
                if matched {
                    for _ in 0..part_len {
                        stack.pop();
                    }
                }
            }
        }

        stack.into_iter().collect()
    }
}