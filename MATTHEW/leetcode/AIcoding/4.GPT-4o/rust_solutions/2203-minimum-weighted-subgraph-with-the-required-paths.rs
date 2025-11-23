use std::collections::{BinaryHeap, HashMap, HashSet};

pub struct Solution;

impl Solution {
    pub fn minimum_weight(n: i32, edges: Vec<Vec<i32>>, src1: i32, src2: i32, dest: i32) -> i32 {
        let mut graph: Vec<Vec<(i32, i32)>> = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push((edge[1], edge[2]));
        }

        let d1 = Self::dijkstra(n, &graph, src1);
        let d2 = Self::dijkstra(n, &graph, src2);
        let d3 = Self::dijkstra(n, &graph.iter().map(|v| v.iter().map(|&(u, w)| (u, w)).collect::<Vec<_>>()).collect::<Vec<_>>(), dest);

        let mut min_weight = i32::MAX;
        for i in 0..n {
            if d1[i as usize] != i32::MAX && d2[i as usize] != i32::MAX && d3[i as usize] != i32::MAX {
                min_weight = min_weight.min(d1[i as usize] + d2[i as usize] + d3[i as usize]);
            }
        }

        if min_weight == i32::MAX {
            -1
        } else {
            min_weight
        }
    }

    fn dijkstra(n: i32, graph: &Vec<Vec<(i32, i32)>>, src: i32) -> Vec<i32> {
        let mut dist = vec![i32::MAX; n as usize];
        let mut heap = BinaryHeap::new();

        dist[src as usize] = 0;
        heap.push((0, src));

        while let Some((d, u)) = heap.pop() {
            let d = -d;
            if d > dist[u as usize] {
                continue;
            }
            for &(v, w) in &graph[u as usize] {
                let new_dist = d + w;
                if new_dist < dist[v as usize] {
                    dist[v as usize] = new_dist;
                    heap.push((-new_dist, v));
                }
            }
        }

        dist
    }
}