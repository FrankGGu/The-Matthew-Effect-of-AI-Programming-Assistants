use std::collections::VecDeque;

impl Solution {
    pub fn minimum_time(n: i32, relations: Vec<Vec<i32>>, time: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut indegree: Vec<i32> = vec![0; n];
        for relation in &relations {
            let prev = (relation[0] - 1) as usize;
            let next = (relation[1] - 1) as usize;
            adj[prev].push(next);
            indegree[next] += 1;
        }

        let mut q: VecDeque<usize> = VecDeque::new();
        let mut dist: Vec<i32> = vec![0; n];
        for i in 0..n {
            dist[i] = time[i];
            if indegree[i] == 0 {
                q.push_back(i);
            }
        }

        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                dist[v] = dist[v].max(dist[u] + time[v]);
                indegree[v] -= 1;
                if indegree[v] == 0 {
                    q.push_back(v);
                }
            }
        }

        *dist.iter().max().unwrap()
    }
}