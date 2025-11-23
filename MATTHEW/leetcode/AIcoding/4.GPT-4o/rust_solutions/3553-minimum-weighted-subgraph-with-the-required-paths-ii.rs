use std::collections::{BinaryHeap, HashMap, HashSet};

pub fn minimum_weight(n: i32, edges: Vec<Vec<i32>>, src1: i32, src2: i32, dest: i32) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    let mut rev_graph = vec![vec![]; n as usize];

    for edge in edges {
        let u = edge[0] as usize;
        let v = edge[1] as usize;
        let w = edge[2];
        graph[u].push((v, w));
        rev_graph[v].push((u, w));
    }

    let d1 = dijkstra(n, &graph, src1);
    let d2 = dijkstra(n, &graph, src2);
    let d3 = dijkstra(n, &rev_graph, dest);

    let mut min_weight = i32::MAX;

    for i in 0..n {
        if d1[i as usize] < i32::MAX && d2[i as usize] < i32::MAX && d3[i as usize] < i32::MAX {
            min_weight = min_weight.min(d1[i as usize] + d2[i as usize] + d3[i as usize]);
        }
    }

    if min_weight == i32::MAX { -1 } else { min_weight }
}

fn dijkstra(n: i32, graph: &Vec<Vec<(usize, i32)>>, src: i32) -> Vec<i32> {
    let mut dist = vec![i32::MAX; n as usize];
    dist[src as usize] = 0;
    let mut heap = BinaryHeap::new();
    heap.push((0, src));

    while let Some((d, u)) = heap.pop() {
        let d = -d;
        if d > dist[u as usize] {
            continue;
        }
        for &(v, w) in &graph[u as usize] {
            let new_dist = d + w;
            if new_dist < dist[v] {
                dist[v] = new_dist;
                heap.push((-new_dist, v as i32));
            }
        }
    }

    dist
}