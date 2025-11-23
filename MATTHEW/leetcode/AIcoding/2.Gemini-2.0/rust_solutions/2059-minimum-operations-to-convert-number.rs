use std::collections::VecDeque;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>, start: i32, goal: i32) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        let mut visited = vec![false; 1001];
        if start >= 0 && start <= 1000 {
            visited[start as usize] = true;
        }

        while let Some((curr, steps)) = queue.pop_front() {
            if curr == goal {
                return steps;
            }

            for &num in &nums {
                let next1 = curr + num;
                let next2 = curr - num;
                let next3 = curr ^ num;

                if next1 == goal || next2 == goal || next3 == goal {
                    return steps + 1;
                }

                if next1 >= 0 && next1 <= 1000 && !visited[next1 as usize] {
                    queue.push_back((next1, steps + 1));
                    visited[next1 as usize] = true;
                }
                if next2 >= 0 && next2 <= 1000 && !visited[next2 as usize] {
                    queue.push_back((next2, steps + 1));
                    visited[next2 as usize] = true;
                }
                if next3 >= 0 && next3 <= 1000 && !visited[next3 as usize] {
                    queue.push_back((next3, steps + 1));
                    visited[next3 as usize] = true;
                }
            }
        }

        -1
    }
}