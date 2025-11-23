impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_valid_strings(letters: String, target: String) -> i32 {
        let mut words = HashSet::new();
        for c in letters.chars() {
            words.insert(c);
        }

        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();
        let mut result = 0;

        for &c in target.as_bytes() {
            if !words.contains(&c as &char) {
                return -1;
            }
        }

        queue.push_back((0, 0));
        visited.insert(0);

        while let Some((pos, count)) = queue.pop_front() {
            if pos == target.len() {
                return count;
            }

            for i in 1..=target.len() - pos {
                let substr = &target[pos..pos + i];
                if substr.chars().all(|c| words.contains(&c)) {
                    let next_pos = pos + i;
                    if !visited.contains(&next_pos) {
                        visited.insert(next_pos);
                        queue.push_back((next_pos, count + 1));
                    }
                }
            }
        }

        -1
    }
}
}