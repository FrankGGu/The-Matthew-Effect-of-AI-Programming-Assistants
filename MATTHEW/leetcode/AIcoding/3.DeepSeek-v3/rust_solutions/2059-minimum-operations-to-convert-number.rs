use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>, start: i32, goal: i32) -> i32 {
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        visited.insert(start);

        while let Some((current, steps)) = queue.pop_front() {
            if current == goal {
                return steps;
            }
            if current < 0 || current > 1000 {
                continue;
            }
            for &num in &nums {
                for next in [current + num, current - num, current ^ num].iter() {
                    if *next == goal {
                        return steps + 1;
                    }
                    if *next >= 0 && *next <= 1000 && !visited.contains(next) {
                        visited.insert(*next);
                        queue.push_back((*next, steps + 1));
                    }
                }
            }
        }
        -1
    }
}