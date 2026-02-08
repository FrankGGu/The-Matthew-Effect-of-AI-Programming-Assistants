use std::collections::{BinaryHeap, HashMap};

pub fn min_cost(n: i32, edges: Vec<Vec<i32>>, start: i32, end: i32, max_time: i32) -> i32 {
    let mut graph = HashMap::new();
    for edge in edges {
        let (u, v, cost) = (edge[0], edge[1], edge[2]);
        graph.entry(u).or_insert(Vec::new()).push((v, cost));
        graph.entry(v).or_insert(Vec::new()).push((u, cost));
    }

    let mut heap = BinaryHeap::new();
    heap.push((0, start, 0)); // (cost, node, time)
    let mut dist = vec![std::i32::MAX; n as usize + 1];
    dist[start as usize] = 0;

    while let Some((cost, node, time)) = heap.pop() {
        let cost = -cost;
        if node == end {
            return cost;
        }
        if time > max_time {
            continue;
        }
        for &(neighbor, edge_cost) in graph.get(&node).unwrap_or(&Vec::new()).iter() {
            let new_cost = cost + edge_cost;
            let new_time = time + edge_cost;
            if new_time <= max_time && new_cost < dist[neighbor as usize] {
                dist[neighbor as usize] = new_cost;
                heap.push((-new_cost, neighbor, new_time));
            }
        }
    }

    -1
}