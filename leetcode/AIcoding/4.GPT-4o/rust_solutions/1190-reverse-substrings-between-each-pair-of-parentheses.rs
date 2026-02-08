impl Solution {
    pub fn reverse_parentheses(s: String) -> String {
        let mut stack = vec![];
        let mut current = String::new();

        for c in s.chars() {
            if c == '(' {
                stack.push(current);
                current = String::new();
            } else if c == ')' {
                current = stack.pop().unwrap() + &current.chars().rev().collect::<String>();
            } else {
                current.push(c);
            }
        }

        current
    }
}