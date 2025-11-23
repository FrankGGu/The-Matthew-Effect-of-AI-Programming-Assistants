use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn find_lex_smallest_string(s: String, a: i32, b: i32) -> String {
        let n = s.len();
        let mut min_s = s.clone();

        let mut queue: VecDeque<String> = VecDeque::new();
        let mut visited: HashSet<String> = HashSet::new();

        queue.push_back(s.clone());
        visited.insert(s.clone());

        while let Some(curr_s) = queue.pop_front() {
            // Update min_s
            if curr_s < min_s {
                min_s = curr_s.clone();
            }

            // Operation 1: Increment characters at odd indices by 'a'
            let mut next_s_inc_bytes = curr_s.as_bytes().to_vec();
            for i in (1..n).step_by(2) {
                let digit = (next_s_inc_bytes[i] - b'0' + a as u8) % 10;
                next_s_inc_bytes[i] = digit + b'0';
            }
            let next_s_inc = String::from_utf8(next_s_inc_bytes).unwrap();

            if !visited.contains(&next_s_inc) {
                visited.insert(next_s_inc.clone());
                queue.push_back(next_s_inc);
            }

            // Operation 2: Rotate the string by 'b'
            let next_s_rot = curr_s[n - (b as usize % n)..].to_string() + &curr_s[..n - (b as usize % n)];

            if !visited.contains(&next_s_rot) {
                visited.insert(next_s_rot.clone());
                queue.push_back(next_s_rot);
            }
        }

        min_s
    }
}