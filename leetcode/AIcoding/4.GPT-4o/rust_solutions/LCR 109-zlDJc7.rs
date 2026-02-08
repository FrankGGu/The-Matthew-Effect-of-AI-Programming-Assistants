use std::collections::VecDeque;

pub fn open_lock(deadends: Vec<String>, target: String) -> i32 {
    let deadends: std::collections::HashSet<String> = deadends.into_iter().collect();
    if deadends.contains("0000") {
        return -1;
    }
    if target == "0000" {
        return 0;
    }

    let mut queue = VecDeque::new();
    let mut visited = std::collections::HashSet::new();
    queue.push_back("0000".to_string());
    visited.insert("0000".to_string());

    let mut steps = 0;

    while !queue.is_empty() {
        let size = queue.len();
        for _ in 0..size {
            let current = queue.pop_front().unwrap();
            for i in 0..4 {
                for &d in [-1, 1].iter() {
                    let next = format!("{:0>4}", (current[i..i + 1].parse::<i32>().unwrap() + d + 10) % 10);
                    let next = format!("{}{}{}", &current[0..i], next, &current[i + 1..]);
                    if next == target {
                        return steps + 1;
                    }
                    if !visited.contains(&next) && !deadends.contains(&next) {
                        visited.insert(next.clone());
                        queue.push_back(next);
                    }
                }
            }
        }
        steps += 1;
    }
    -1
}