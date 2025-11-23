use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn min_jumps(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n == 1 {
            return 0;
        }
        let mut value_indices = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            value_indices.entry(num).or_insert_with(Vec::new).push(i);
        }
        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back(0);
        visited[0] = true;
        let mut steps = 0;
        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let current = queue.pop_front().unwrap();
                if current == n - 1 {
                    return steps;
                }
                if current > 0 && !visited[current - 1] {
                    visited[current - 1] = true;
                    queue.push_back(current - 1);
                }
                if current < n - 1 && !visited[current + 1] {
                    visited[current + 1] = true;
                    queue.push_back(current + 1);
                }
                if let Some(indices) = value_indices.get(&arr[current]) {
                    for &next in indices {
                        if !visited[next] {
                            visited[next] = true;
                            queue.push_back(next);
                        }
                    }
                    value_indices.remove(&arr[current]);
                }
            }
            steps += 1;
        }
        -1
    }
}