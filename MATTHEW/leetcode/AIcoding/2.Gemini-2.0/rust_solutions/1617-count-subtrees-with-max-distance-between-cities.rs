impl Solution {
    pub fn count_subtrees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in &edges {
            let u = (edge[0] - 1) as usize;
            let v = (edge[1] - 1) as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans = vec![0; n - 1];

        for i in 1..(1 << n) {
            if i.count_ones() < 2 {
                continue;
            }

            let mut nodes = vec![];
            for j in 0..n {
                if (i >> j) & 1 == 1 {
                    nodes.push(j);
                }
            }

            let mut sub_adj = vec![vec![]; n];
            let mut edge_count = 0;
            for edge in &edges {
                let u = (edge[0] - 1) as usize;
                let v = (edge[1] - 1) as usize;
                if (i >> u) & 1 == 1 && (i >> v) & 1 == 1 {
                    sub_adj[u].push(v);
                    sub_adj[v].push(u);
                    edge_count += 1;
                }
            }

            if edge_count != nodes.len() - 1 {
                continue;
            }

            let mut visited = vec![false; n];
            let mut q = std::collections::VecDeque::new();
            q.push_back(nodes[0]);
            visited[nodes[0]] = true;
            let mut count = 0;

            while let Some(u) = q.pop_front() {
                count += 1;
                for &v in &sub_adj[u] {
                    if !visited[v] && (i >> v) & 1 == 1 {
                        visited[v] = true;
                        q.push_back(v);
                    }
                }
            }

            if count != nodes.len() {
                continue;
            }

            let mut max_dist = 0;
            for start_node in &nodes {
                for end_node in &nodes {
                    let dist = bfs(*start_node, *end_node, &sub_adj, n, i);
                    max_dist = max_dist.max(dist);
                }
            }

            ans[max_dist as usize - 1] += 1;
        }

        ans
    }
}

fn bfs(start: usize, end: usize, adj: &Vec<Vec<usize>>, n: usize, mask: i32) -> i32 {
    if start == end {
        return 0;
    }

    let mut dist = vec![-1; n];
    let mut q = std::collections::VecDeque::new();
    q.push_back(start);
    dist[start] = 0;

    while let Some(u) = q.pop_front() {
        for &v in &adj[u] {
            if dist[v] == -1 && ((mask >> v) & 1) == 1 {
                dist[v] = dist[u] + 1;
                q.push_back(v);
            }
        }
    }

    dist[end]
}

struct Solution;