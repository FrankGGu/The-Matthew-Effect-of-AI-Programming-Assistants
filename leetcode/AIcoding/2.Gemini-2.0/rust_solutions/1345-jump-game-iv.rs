use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn min_jumps(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n <= 1 {
            return 0;
        }

        let mut indices: HashMap<i32, Vec<usize>> = HashMap::new();
        for i in 0..n {
            indices.entry(arr[i]).or_insert(Vec::new()).push(i);
        }

        let mut visited = vec![false; n];
        visited[0] = true;
        let mut queue: VecDeque<(usize, i32)> = VecDeque::new();
        queue.push_back((0, 0));

        while let Some((curr, steps)) = queue.pop_front() {
            if curr == n - 1 {
                return steps;
            }

            let neighbors = indices.get(&arr[curr]).unwrap();
            for &neighbor in neighbors {
                if !visited[neighbor] {
                    visited[neighbor] = true;
                    queue.push_back((neighbor, steps + 1));
                }
            }
            indices.remove(&arr[curr]);

            if curr > 0 && !visited[curr - 1] {
                visited[curr - 1] = true;
                queue.push_back((curr - 1, steps + 1));
            }

            if curr < n - 1 && !visited[curr + 1] {
                visited[curr + 1] = true;
                queue.push_back((curr + 1, steps + 1));
            }
        }

        0
    }
}