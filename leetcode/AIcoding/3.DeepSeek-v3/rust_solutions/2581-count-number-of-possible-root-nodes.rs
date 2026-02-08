use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn root_count(edges: Vec<Vec<i32>>, guesses: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = edges.len() + 1;
        let mut adj = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let guess_set: HashSet<(usize, usize)> = guesses.into_iter().map(|g| (g[0] as usize, g[1] as usize)).collect();

        let mut parent = vec![0; n];
        let mut correct = 0;
        let mut queue = VecDeque::new();
        queue.push_back(0);
        parent[0] = 0;

        while let Some(u) = queue.pop_front() {
            for &v in &adj[u] {
                if v != parent[u] {
                    parent[v] = u;
                    if guess_set.contains(&(u, v)) {
                        correct += 1;
                    }
                    queue.push_back(v);
                }
            }
        }

        let mut res = 0;
        let mut count = correct;
        if count >= k {
            res += 1;
        }

        let mut stack = Vec::new();
        stack.push((0, count));

        while let Some((u, cnt)) = stack.pop() {
            for &v in &adj[u] {
                if v != parent[u] {
                    let mut new_cnt = cnt;
                    if guess_set.contains(&(u, v)) {
                        new_cnt -= 1;
                    }
                    if guess_set.contains(&(v, u)) {
                        new_cnt += 1;
                    }
                    if new_cnt >= k {
                        res += 1;
                    }
                    stack.push((v, new_cnt));
                }
            }
        }

        res
    }
}