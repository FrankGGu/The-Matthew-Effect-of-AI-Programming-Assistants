use std::collections::{HashMap, VecDeque};

struct Solution;

impl Solution {
    pub fn shortest_path_tree(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist = vec![0; n];
        let mut parent = vec![0; n];
        let mut queue = VecDeque::new();
        queue.push_back(0);
        parent[0] = n; // Mark root's parent as invalid

        while let Some(u) = queue.pop_front() {
            for &(v, w) in &adj[u] {
                if parent[v] == 0 && v != 0 {
                    parent[v] = u;
                    dist[v] = dist[u] + w;
                    queue.push_back(v);
                }
            }
        }

        let mut max_dist = 0;
        let mut x = 0;
        for i in 0..n {
            if dist[i] > max_dist {
                max_dist = dist[i];
                x = i;
            }
        }

        let mut dist_x = vec![0; n];
        let mut parent_x = vec![0; n];
        let mut queue = VecDeque::new();
        queue.push_back(x);
        parent_x[x] = n;

        while let Some(u) = queue.pop_front() {
            for &(v, w) in &adj[u] {
                if parent_x[v] == 0 && v != x {
                    parent_x[v] = u;
                    dist_x[v] = dist_x[u] + w;
                    queue.push_back(v);
                }
            }
        }

        let mut max_dist = 0;
        let mut y = 0;
        for i in 0..n {
            if dist_x[i] > max_dist {
                max_dist = dist_x[i];
                y = i;
            }
        }

        let mut path = vec![];
        let mut u = y;
        while u != n {
            path.push(u);
            u = parent_x[u];
        }

        let mut dist_y = vec![0; n];
        let mut parent_y = vec![0; n];
        let mut queue = VecDeque::new();
        queue.push_back(y);
        parent_y[y] = n;

        while let Some(u) = queue.pop_front() {
            for &(v, w) in &adj[u] {
                if parent_y[v] == 0 && v != y {
                    parent_y[v] = u;
                    dist_y[v] = dist_y[u] + w;
                    queue.push_back(v);
                }
            }
        }

        let mut res = vec![0; n];
        for i in 0..n {
            res[i] = std::cmp::max(dist_x[i], dist_y[i]);
        }

        res
    }
}