struct Solution;

impl Solution {
    pub fn reverse_parentheses(s: String) -> String {
        let mut stack = Vec::new();
        let mut current = String::new();

        for c in s.chars() {
            match c {
                '(' => {
                    stack.push(current);
                    current = String::new();
                },
                ')' => {
                    let prev = stack.pop().unwrap();
                    current = prev + &current.chars().rev().collect::<String>();
                },
                _ => current.push(c),
            }
        }

        current
    }
}