impl Solution {
    pub fn min_length(s: String) -> i32 {
        let mut stack: Vec<char> = Vec::new();

        for c in s.chars() {
            match c {
                'B' => {
                    if let Some(&top) = stack.last() {
                        if top == 'A' {
                            stack.pop();
                        } else {
                            stack.push(c);
                        }
                    } else {
                        stack.push(c);
                    }
                },
                'D' => {
                    if let Some(&top) = stack.last() {
                        if top == 'C' {
                            stack.pop();
                        } else {
                            stack.push(c);
                        }
                    } else {
                        stack.push(c);
                    }
                },
                _ => {
                    stack.push(c);
                }
            }
        }

        stack.len() as i32
    }
}