use std::collections::{HashMap, HashSet, BinaryHeap};

impl Solution {
    pub fn reachable_nodes(edges: Vec<Vec<i32>>, max_moves: i32, n: i32) -> i32 {
        let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for edge in edges.iter() {
            graph.entry(edge[0]).or_default().push((edge[1], edge[2]));
            graph.entry(edge[1]).or_default().push((edge[0], edge[2]));
        }

        let mut heap = BinaryHeap::new();
        let mut dist = vec![i32::MAX; n as usize];
        dist[0] = 0;
        heap.push((0, 0));

        while let Some((d, u)) = heap.pop() {
            let d = -d;
            if d > dist[u as usize] {
                continue;
            }
            for &(v, w) in graph.get(&u).unwrap_or(&vec![]) {
                let new_dist = d + w + 1;
                if new_dist <= max_moves && new_dist < dist[v as usize] {
                    dist[v as usize] = new_dist;
                    heap.push((-new_dist, v));
                }
            }
        }

        let mut reachable = 0;
        for i in 0..n {
            if dist[i as usize] <= max_moves {
                reachable += 1;
            }
        }

        for edge in edges.iter() {
            let u = edge[0];
            let v = edge[1];
            let w = edge[2];
            let reachable_u = if dist[u as usize] <= max_moves { max_moves - dist[u as usize] } else { 0 };
            let reachable_v = if dist[v as usize] <= max_moves { max_moves - dist[v as usize] } else { 0 };
            reachable += reachable_u.min(w) + reachable_v.min(w);
        }

        reachable
    }
}