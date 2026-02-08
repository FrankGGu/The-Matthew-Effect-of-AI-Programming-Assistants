use std::collections::VecDeque;

impl Solution {
    pub fn minimum_time(n: i32, relations: Vec<Vec<i32>>, time: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n + 1];
        let mut in_degree = vec![0; n + 1];
        let mut max_time = vec![0; n + 1];

        for relation in relations {
            let u = relation[0] as usize;
            let v = relation[1] as usize;
            graph[u].push(v);
            in_degree[v] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 1..=n {
            if in_degree[i] == 0 {
                queue.push_back(i);
                max_time[i] = time[i - 1];
            }
        }

        while let Some(u) = queue.pop_front() {
            for &v in &graph[u] {
                if max_time[v] < max_time[u] + time[v - 1] {
                    max_time[v] = max_time[u] + time[v - 1];
                }
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        *max_time.iter().max().unwrap()
    }
}