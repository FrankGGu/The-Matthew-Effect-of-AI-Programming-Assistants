use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn min_jumps(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n <= 1 {
            return 0;
        }

        let mut graph: HashMap<i32, Vec<usize>> = HashMap::new();
        for (i, &val) in arr.iter().enumerate() {
            graph.entry(val).or_default().push(i);
        }

        let mut queue: VecDeque<usize> = VecDeque::new();
        queue.push_back(0);

        let mut visited: Vec<bool> = vec![false; n];
        visited[0] = true;

        let mut steps = 0;

        while !queue.is_empty() {
            let level_size = queue.len();
            for _ in 0..level_size {
                let curr_idx = queue.pop_front().unwrap();

                if curr_idx == n - 1 {
                    return steps;
                }

                // Jump to i + 1
                if curr_idx + 1 < n && !visited[curr_idx + 1] {
                    visited[curr_idx + 1] = true;
                    queue.push_back(curr_idx + 1);
                }

                // Jump to i - 1
                if curr_idx > 0 && !visited[curr_idx - 1] {
                    visited[curr_idx - 1] = true;
                    queue.push_back(curr_idx - 1);
                }

                // Jump to j where arr[j] == arr[i]
                if let Some(indices) = graph.get(&arr[curr_idx]) {
                    for &next_idx in indices {
                        if !visited[next_idx] {
                            visited[next_idx] = true;
                            queue.push_back(next_idx);
                        }
                    }
                }
                // Clear the list of indices for arr[curr_idx] to avoid re-processing them.
                // This is crucial for performance, as each group of same-value indices
                // only needs to be processed once.
                graph.remove(&arr[curr_idx]);
            }
            steps += 1;
        }

        // Should not be reached if a path always exists
        -1
    }
}