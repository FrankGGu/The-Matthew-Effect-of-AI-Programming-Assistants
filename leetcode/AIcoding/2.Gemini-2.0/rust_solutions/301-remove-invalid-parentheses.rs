use std::collections::VecDeque;

impl Solution {
    pub fn remove_invalid_parentheses(s: String) -> Vec<String> {
        let mut result = Vec::new();
        let mut visited = std::collections::HashSet::new();
        let mut queue = VecDeque::new();

        queue.push_back(s.clone());
        visited.insert(s.clone());

        let mut found = false;

        while !queue.is_empty() {
            let current = queue.pop_front().unwrap();

            if Self::is_valid(&current) {
                result.push(current.clone());
                found = true;
            }

            if found {
                continue;
            }

            for i in 0..current.len() {
                if current.chars().nth(i).unwrap() != '(' && current.chars().nth(i).unwrap() != ')' {
                    continue;
                }

                let mut next = current.clone();
                next.remove(i);

                if !visited.contains(&next) {
                    queue.push_back(next.clone());
                    visited.insert(next.clone());
                }
            }
        }

        if result.is_empty() {
            result.push("".to_string());
        }

        result
    }

    fn is_valid(s: &str) -> bool {
        let mut count = 0;
        for c in s.chars() {
            if c == '(' {
                count += 1;
            } else if c == ')' {
                count -= 1;
                if count < 0 {
                    return false;
                }
            }
        }
        count == 0
    }
}

struct Solution;