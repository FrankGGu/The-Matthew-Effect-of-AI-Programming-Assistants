use std::collections::VecDeque;

pub fn open_lock(deadends: Vec<String>, target: String) -> i32 {
    let deadends: std::collections::HashSet<_> = deadends.into_iter().collect();
    let target = target.as_bytes();
    if deadends.contains("0000") {
        return -1;
    }
    if target == b"0000" {
        return 0;
    }

    let mut queue = VecDeque::new();
    let mut visited = std::collections::HashSet::new();
    queue.push_back("0000".to_string());
    visited.insert("0000");

    let mut steps = 0;

    while !queue.is_empty() {
        let size = queue.len();
        for _ in 0..size {
            let curr = queue.pop_front().unwrap();
            for i in 0..4 {
                for d in [-1, 1] {
                    let mut next = curr.clone().into_bytes();
                    next[i] = ((next[i] - b'0' + d + 10) % 10 + b'0') as u8);
                    let next_str = String::from_utf8(next.clone()).unwrap();

                    if !visited.contains(&next_str) && !deadends.contains(&next_str) {
                        if next_str == target {
                            return steps + 1;
                        }
                        visited.insert(next_str.clone());
                        queue.push_back(next_str);
                    }
                }
            }
        }
        steps += 1;
    }
    -1
}