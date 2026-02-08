impl Solution {
    pub fn remove_duplicates(s: String, k: i32) -> String {
        let mut stack: Vec<(char, i32)> = Vec::new();
        for c in s.chars() {
            if let Some(&(top_char, count)) = stack.last() {
                if top_char == c {
                    if count + 1 == k {
                        stack.pop();
                    } else {
                        *stack.last_mut().unwrap() = (c, count + 1);
                    }
                } else {
                    stack.push((c, 1));
                }
            } else {
                stack.push((c, 1));
            }
        }

        let mut result = String::new();
        for (c, count) in stack {
            for _ in 0..count {
                result.push(c);
            }
        }
        result
    }
}