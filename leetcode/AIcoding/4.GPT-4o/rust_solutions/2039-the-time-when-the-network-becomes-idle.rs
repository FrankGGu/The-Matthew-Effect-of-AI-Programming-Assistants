pub fn network_becomes_idle(edges: Vec<Vec<i32>>, patience: Vec<i32>) -> i32 {
    use std::collections::{BinaryHeap, HashMap};

    let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
    for edge in edges {
        graph.entry(edge[0]).or_insert_with(Vec::new).push((edge[1], 1));
        graph.entry(edge[1]).or_insert_with(Vec::new).push((edge[0], 1));
    }

    let n = patience.len() as i32;
    let mut dist = vec![i32::MAX; n as usize];
    let mut heap = BinaryHeap::new();
    dist[0 as usize] = 0;
    heap.push((0, 0));

    while let Some((d, u)) = heap.pop() {
        let d = -d;
        if d > dist[u as usize] {
            continue;
        }
        for &(v, w) in &graph[&u] {
            if dist[v as usize] > d + w {
                dist[v as usize] = d + w;
                heap.push((-dist[v as usize], v));
            }
        }
    }

    let mut max_time = 0;
    for i in 1..n {
        let round_trip_time = dist[i as usize] * 2;
        let wait_time = (round_trip_time - 1) / patience[i as usize];
        max_time = max_time.max(round_trip_time + wait_time * patience[i as usize]);
    }

    max_time + 1
}