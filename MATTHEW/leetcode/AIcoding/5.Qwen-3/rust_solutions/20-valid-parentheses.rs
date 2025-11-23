impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack = Vec::new();
        let mut map = HashMap::new();
        map.insert(')', '(');
        map.insert(']', '[');
        map.insert('}', '{');

        for c in s.chars() {
            match c {
                '(' | '[' | '{' => stack.push(c),
                ')' | ']' | '}' => {
                    if stack.pop() != map.get(&c) {
                        return false;
                    }
                },
                _ => return false,
            }
        }

        stack.is_empty()
    }
}
}