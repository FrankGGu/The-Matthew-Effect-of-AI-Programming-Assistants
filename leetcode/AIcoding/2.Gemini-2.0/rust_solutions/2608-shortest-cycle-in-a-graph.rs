use std::collections::VecDeque;

impl Solution {
    pub fn find_shortest_cycle(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans = i32::MAX;

        for start_node in 0..n {
            let mut dist: Vec<i32> = vec![-1; n];
            let mut parent: Vec<i32> = vec![-1; n];
            let mut q: VecDeque<usize> = VecDeque::new();

            dist[start_node] = 0;
            q.push_back(start_node);

            while let Some(u) = q.pop_front() {
                for &v in &adj[u] {
                    if dist[v] == -1 {
                        dist[v] = dist[u] + 1;
                        parent[v] = u as i32;
                        q.push_back(v);
                    } else if parent[u] != v as i32 && parent[v] != u as i32 {
                        ans = ans.min(dist[u] + dist[v] + 1);
                    }
                }
            }
        }

        if ans == i32::MAX {
            -1
        } else {
            ans
        }
    }
}