use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn chase_game(edges: Vec<Vec<i32>>, start_a: i32, start_b: i32) -> i32 {
        let n = edges.len();
        let mut adj = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut cycle_nodes = HashSet::new();
        let mut visited = vec![0; n + 1];
        let mut parent = vec![0; n + 1];
        let mut found = false;
        let mut stack = Vec::new();
        stack.push((1, 0));
        visited[1] = 1;

        while let Some((u, p)) = stack.pop() {
            parent[u] = p;
            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                if visited[v] == 1 {
                    let mut node = u;
                    cycle_nodes.insert(v);
                    while node != v {
                        cycle_nodes.insert(node);
                        node = parent[node];
                    }
                    found = true;
                    break;
                } else {
                    visited[v] = 1;
                    stack.push((v, u));
                }
            }
            if found {
                break;
            }
        }

        let mut dist_a = vec![-1; n + 1];
        let mut dist_b = vec![-1; n + 1];
        let mut q = VecDeque::new();

        q.push_back(start_a as usize);
        dist_a[start_a as usize] = 0;
        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if dist_a[v] == -1 {
                    dist_a[v] = dist_a[u] + 1;
                    q.push_back(v);
                }
            }
        }

        q.push_back(start_b as usize);
        dist_b[start_b as usize] = 0;
        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if dist_b[v] == -1 {
                    dist_b[v] = dist_b[u] + 1;
                    q.push_back(v);
                }
            }
        }

        let mut max_dist = 0;
        for u in 1..=n {
            if dist_a[u] > dist_b[u] + 1 {
                if cycle_nodes.contains(&u) && cycle_nodes.len() > 3 {
                    return -1;
                }
                max_dist = max_dist.max(dist_a[u]);
            }
        }

        max_dist
    }
}