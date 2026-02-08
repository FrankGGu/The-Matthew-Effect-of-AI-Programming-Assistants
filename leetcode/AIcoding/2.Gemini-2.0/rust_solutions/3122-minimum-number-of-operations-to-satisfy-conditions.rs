impl Solution {
    pub fn minimum_operations(nums: Vec<i32>, start: i32, goal: i32) -> i32 {
        use std::collections::VecDeque;

        let mut q = VecDeque::new();
        q.push_back((start, 0));

        let mut visited = vec![false; 1001];
        visited[start as usize] = true;

        while let Some((curr, steps)) = q.pop_front() {
            if curr == goal {
                return steps;
            }

            for &num in &nums {
                let next1 = curr + num;
                let next2 = curr - num;
                let next3 = curr ^ num;

                if next1 >= 0 && next1 <= 1000 && !visited[next1 as usize] {
                    q.push_back((next1, steps + 1));
                    visited[next1 as usize] = true;
                } else if next1 == goal {
                    return steps + 1;
                }

                if next2 >= 0 && next2 <= 1000 && !visited[next2 as usize] {
                    q.push_back((next2, steps + 1));
                    visited[next2 as usize] = true;
                } else if next2 == goal {
                    return steps + 1;
                }

                if next3 >= 0 && next3 <= 1000 && !visited[next3 as usize] {
                    q.push_back((next3, steps + 1));
                    visited[next3 as usize] = true;
                } else if next3 == goal {
                    return steps + 1;
                }
            }
        }

        -1
    }
}