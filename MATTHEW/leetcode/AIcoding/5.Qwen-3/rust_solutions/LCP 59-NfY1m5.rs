impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_jumps(arr: Vec<i32>, start: i32, end: i32) -> i32 {
        let n = arr.len();
        let mut graph = std::collections::HashMap::new();

        for (i, &val) in arr.iter().enumerate() {
            graph.entry(val).or_insert(Vec::new()).push(i);
        }

        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back((start as usize, 0));
        visited[start as usize] = true;

        while let Some((current, steps)) = queue.pop_front() {
            if current == end as usize {
                return steps;
            }

            for &neighbor in &graph[&arr[current]] {
                if !visited[neighbor] {
                    visited[neighbor] = true;
                    queue.push_back((neighbor, steps + 1));
                }
            }

            if current > 0 && !visited[current - 1] {
                visited[current - 1] = true;
                queue.push_back((current - 1, steps + 1));
            }

            if current < n - 1 && !visited[current + 1] {
                visited[current + 1] = true;
                queue.push_back((current + 1, steps + 1));
            }
        }

        -1
    }
}
}