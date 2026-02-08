use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn open_lock(deadends: Vec<String>, target: String) -> i32 {
        let mut visited = HashSet::new();
        for deadend in deadends {
            visited.insert(deadend);
        }
        if visited.contains("0000") {
            return -1;
        }
        let target = target;
        let mut queue = VecDeque::new();
        queue.push_back(("0000".to_string(), 0));
        visited.insert("0000".to_string());

        while let Some((current, steps)) = queue.pop_front() {
            if current == target {
                return steps;
            }
            for i in 0..4 {
                let digit = current.chars().nth(i).unwrap().to_digit(10).unwrap();
                for delta in [1, 9].iter() {
                    let new_digit = (digit + delta) % 10;
                    let mut next = current.chars().collect::<Vec<char>>();
                    next[i] = std::char::from_digit(new_digit, 10).unwrap();
                    let next_str = next.iter().collect::<String>();
                    if !visited.contains(&next_str) {
                        visited.insert(next_str.clone());
                        queue.push_back((next_str, steps + 1));
                    }
                }
            }
        }
        -1
    }
}