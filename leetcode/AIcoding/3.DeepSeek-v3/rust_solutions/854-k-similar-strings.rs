use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn k_similarity(s1: String, s2: String) -> i32 {
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();
        queue.push_back((s1.into_bytes(), 0));
        visited.insert(s2.clone().into_bytes());

        while let Some((current, steps)) = queue.pop_front() {
            if current == s2.as_bytes() {
                return steps;
            }
            let mut i = 0;
            while i < current.len() && current[i] == s2.as_bytes()[i] {
                i += 1;
            }
            if i == current.len() {
                continue;
            }
            for j in i + 1..current.len() {
                if current[j] == s2.as_bytes()[i] {
                    let mut next = current.clone();
                    next.swap(i, j);
                    if !visited.contains(&next) {
                        visited.insert(next.clone());
                        queue.push_back((next, steps + 1));
                    }
                }
            }
        }
        -1
    }
}