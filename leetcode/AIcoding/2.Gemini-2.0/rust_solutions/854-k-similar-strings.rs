use std::collections::VecDeque;

impl Solution {
    pub fn k_similarity(s1: String, s2: String) -> i32 {
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let n = s1.len();

        let mut queue = VecDeque::new();
        queue.push_back((s1, 0));

        let mut visited = std::collections::HashSet::new();
        visited.insert(s1.clone());

        let mut steps = 0;
        while !queue.is_empty() {
            let len = queue.len();
            for _ in 0..len {
                let (curr, idx) = queue.pop_front().unwrap();
                if curr == s2 {
                    return steps;
                }

                let curr_bytes = curr.as_bytes();

                let mut i = idx;
                while i < n && curr_bytes[i] == s2_bytes[i] {
                    i += 1;
                }

                for j in i + 1..n {
                    if curr_bytes[j] == s2_bytes[i] && curr_bytes[j] != s2_bytes[j] {
                        let mut next_bytes = curr_bytes.to_vec();
                        next_bytes.swap(i, j);
                        let next = String::from_utf8(next_bytes).unwrap();
                        if !visited.contains(&next) {
                            queue.push_back((next.clone(), i + 1));
                            visited.insert(next);
                        }
                    }
                }
            }
            steps += 1;
        }

        0
    }
}