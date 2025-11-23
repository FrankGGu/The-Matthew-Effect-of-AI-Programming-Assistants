use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn find_lex_smallest_string(s: String, a: i32, b: i32) -> String {
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(s.clone());
        visited.insert(s);
        let mut min_str = s;

        while let Some(current) = queue.pop_front() {
            if current < min_str {
                min_str = current.clone();
            }

            let add_op = Self::add(&current, a);
            if visited.insert(add_op.clone()) {
                queue.push_back(add_op);
            }

            let rotate_op = Self::rotate(&current, b as usize);
            if visited.insert(rotate_op.clone()) {
                queue.push_back(rotate_op);
            }
        }

        min_str
    }

    fn add(s: &str, a: i32) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        for i in (1..chars.len()).step_by(2) {
            let digit = chars[i].to_digit(10).unwrap() as i32;
            let new_digit = (digit + a) % 10;
            chars[i] = std::char::from_digit(new_digit as u32, 10).unwrap();
        }
        chars.into_iter().collect()
    }

    fn rotate(s: &str, b: usize) -> String {
        let n = s.len();
        let split_pos = n - b;
        let (left, right) = s.split_at(split_pos);
        format!("{}{}", right, left)
    }
}