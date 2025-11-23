use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn find_lex_smallest_string(s: String, a: i32, b: i32) -> String {
        let n = s.len();
        let mut queue: VecDeque<String> = VecDeque::new();
        let mut visited: HashSet<String> = HashSet::new();
        let mut min_string = s.clone();

        queue.push_back(s.clone());
        visited.insert(s.clone());

        while let Some(current_s) = queue.pop_front() {
            if current_s < min_string {
                min_string = current_s.clone();
            }

            // Operation 1: Add 'a' to digits at odd indices
            let mut chars: Vec<char> = current_s.chars().collect();
            for i in (1..n).step_by(2) {
                let digit = chars[i].to_digit(10).unwrap();
                let new_digit = (digit + a as u32) % 10;
                chars[i] = char::from_digit(new_digit, 10).unwrap();
            }
            let next_s1 = chars.into_iter().collect::<String>();

            if visited.insert(next_s1.clone()) {
                queue.push_back(next_s1);
            }

            // Operation 2: Rotate string by 'b' positions to the right
            let mut chars: Vec<char> = current_s.chars().collect();
            chars.rotate_right(b as usize);
            let next_s2 = chars.into_iter().collect::<String>();

            if visited.insert(next_s2.clone()) {
                queue.push_back(next_s2);
            }
        }

        min_string
    }
}