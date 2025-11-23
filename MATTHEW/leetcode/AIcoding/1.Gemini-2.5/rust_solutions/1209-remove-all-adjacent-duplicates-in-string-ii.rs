struct Solution;

impl Solution {
    pub fn remove_duplicates(s: String, k: i32) -> String {
        let mut stack: Vec<(char, i32)> = Vec::new();

        for c in s.chars() {
            if let Some(top) = stack.last_mut() {
                if top.0 == c {
                    top.1 += 1;
                    if top.1 == k {
                        stack.pop();
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