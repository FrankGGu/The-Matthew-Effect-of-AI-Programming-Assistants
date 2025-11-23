use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn reachable_nodes(edges: Vec<Vec<i32>>, max_moves: i32, n: i32) -> i32 {
        let n = n as usize;
        let max_moves = max_moves as i32;
        let mut graph = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let cnt = edge[2];
            graph[u].push((v, cnt));
            graph[v].push((u, cnt));
        }

        let mut dist = vec![i32::MAX; n];
        let mut heap = BinaryHeap::new();
        heap.push(Reverse((0, 0)));
        dist[0] = 0;

        while let Some(Reverse((d, u))) = heap.pop() {
            if d > dist[u] {
                continue;
            }
            for &(v, cnt) in &graph[u] {
                let new_dist = d + cnt + 1;
                if new_dist < dist[v] {
                    dist[v] = new_dist;
                    heap.push(Reverse((new_dist, v)));
                }
            }
        }

        let mut res = 0;
        for &d in &dist {
            if d <= max_moves {
                res += 1;
            }
        }

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let cnt = edge[2];
            let a = (max_moves - dist[u]).max(0);
            let b = (max_moves - dist[v]).max(0);
            res += (a + b).min(cnt);
        }

        res
    }
}