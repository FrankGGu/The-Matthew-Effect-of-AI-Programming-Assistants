impl Solution {
    pub fn count_subgraphs_for_each_diameter(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj = vec![vec![false; n]; n];
        for edge in edges {
            let u = edge[0] as usize - 1;
            let v = edge[1] as usize - 1;
            adj[u][v] = true;
            adj[v][u] = true;
        }

        let mut res = vec![0; n - 1];
        for mask in 1..(1 << n) {
            let mut nodes = Vec::new();
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    nodes.push(i);
                }
            }
            if nodes.len() < 2 {
                continue;
            }
            let mut is_connected = true;
            let mut visited = vec![false; n];
            let mut stack = vec![nodes[0]];
            visited[nodes[0]] = true;
            let mut count = 1;
            while let Some(u) = stack.pop() {
                for &v in &nodes {
                    if adj[u][v] && !visited[v] {
                        visited[v] = true;
                        stack.push(v);
                        count += 1;
                    }
                }
            }
            if count != nodes.len() {
                continue;
            }
            let mut max_dist = 0;
            for &u in &nodes {
                let mut dist = vec![-1; n];
                let mut q = std::collections::VecDeque::new();
                q.push_back(u);
                dist[u] = 0;
                while let Some(v) = q.pop_front() {
                    for &w in &nodes {
                        if adj[v][w] && dist[w] == -1 {
                            dist[w] = dist[v] + 1;
                            q.push_back(w);
                        }
                    }
                }
                let current_max = *dist.iter().max().unwrap();
                if current_max > max_dist {
                    max_dist = current_max;
                }
            }
            if max_dist > 0 {
                res[max_dist as usize - 1] += 1;
            }
        }
        res
    }
}