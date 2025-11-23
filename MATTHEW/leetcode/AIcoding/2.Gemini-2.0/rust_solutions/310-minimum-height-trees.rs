use std::collections::VecDeque;

impl Solution {
    pub fn find_min_height_trees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        if n == 1 {
            return vec![0];
        }

        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        let mut degree = vec![0; n];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut queue: VecDeque<usize> = VecDeque::new();
        for i in 0..n {
            if degree[i] == 1 {
                queue.push_back(i);
            }
        }

        let mut count = n;
        while count > 2 {
            let size = queue.len();
            count -= size;

            for _ in 0..size {
                let u = queue.pop_front().unwrap();
                degree[u] = 0;

                for &v in &adj[u] {
                    degree[v] -= 1;
                    if degree[v] == 1 {
                        queue.push_back(v);
                    }
                }
            }
        }

        let mut result = Vec::new();
        for i in 0..n {
            if degree[i] > 0 {
                result.push(i as i32);
            }
        }

        result
    }
}