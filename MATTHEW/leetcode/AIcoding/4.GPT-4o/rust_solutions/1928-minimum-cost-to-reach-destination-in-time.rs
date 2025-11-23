use std::collections::BinaryHeap;

pub fn min_cost(n: i32, edges: Vec<Vec<i32>>, time: i32, change: i32) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    for edge in edges {
        graph[edge[0] as usize].push((edge[1], edge[2]));
        graph[edge[1] as usize].push((edge[0], edge[2]));
    }

    let mut dist = vec![i32::MAX; n as usize];
    dist[0] = 0;
    let mut pq = BinaryHeap::new();
    pq.push((0, 0)); // (cost, node)

    while let Some((cost, u)) = pq.pop() {
        let cost = -cost;
        if u == (n - 1) {
            return cost;
        }
        if cost > dist[u as usize] {
            continue;
        }
        for &(v, travel_time) in &graph[u as usize] {
            let arrival_time = cost + travel_time;
            let wait_time = if arrival_time % change == 0 {
                0
            } else {
                change - (arrival_time % change)
            };
            let new_cost = arrival_time + wait_time;
            if new_cost < dist[v as usize] {
                dist[v as usize] = new_cost;
                pq.push((-new_cost, v));
            }
        }
    }
    -1
}