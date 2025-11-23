impl Solution {
    pub fn reverse_parentheses(s: String) -> String {
        let mut stack = Vec::new();
        let mut queue = Vec::new();

        for c in s.chars() {
            if c == ')' {
                while let Some(top) = stack.pop() {
                    if top == '(' {
                        break;
                    }
                    queue.push(top);
                }
                while let Some(q) = queue.pop() {
                    stack.push(q);
                }
            } else {
                stack.push(c);
            }
        }

        stack.into_iter().collect()
    }
}