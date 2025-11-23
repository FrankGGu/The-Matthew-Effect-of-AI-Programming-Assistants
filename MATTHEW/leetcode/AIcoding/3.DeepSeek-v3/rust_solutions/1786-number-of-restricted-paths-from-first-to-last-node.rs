use std::collections::{BinaryHeap, HashMap};

#[derive(PartialEq, Eq)]
struct State {
    node: usize,
    dist: i32,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.dist.cmp(&self.dist)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn count_restricted_paths(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist = vec![i32::MAX; n + 1];
        dist[n] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(State { node: n, dist: 0 });

        while let Some(State { node, dist: current_dist }) = heap.pop() {
            if current_dist > dist[node] {
                continue;
            }
            for &(neighbor, weight) in &adj[node] {
                let new_dist = current_dist + weight;
                if new_dist < dist[neighbor] {
                    dist[neighbor] = new_dist;
                    heap.push(State { node: neighbor, dist: new_dist });
                }
            }
        }

        let mut memo = HashMap::new();
        Self::dfs(1, n, &dist, &adj, &mut memo)
    }

    fn dfs(node: usize, n: usize, dist: &[i32], adj: &[Vec<(usize, i32)>], memo: &mut HashMap<usize, i32>) -> i32 {
        if node == n {
            return 1;
        }
        if let Some(&count) = memo.get(&node) {
            return count;
        }

        let mut res = 0;
        for &(neighbor, _) in &adj[node] {
            if dist[neighbor] < dist[node] {
                res = (res + Self::dfs(neighbor, n, dist, adj, memo)) % 1_000_000_007;
            }
        }
        memo.insert(node, res);
        res
    }
}