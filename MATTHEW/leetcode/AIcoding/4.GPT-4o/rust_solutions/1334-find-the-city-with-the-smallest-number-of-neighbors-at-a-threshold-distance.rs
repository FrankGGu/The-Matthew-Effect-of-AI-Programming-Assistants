use std::collections::{HashMap, BinaryHeap};

pub fn find_the_city(n: i32, edges: Vec<Vec<i32>>, distance_threshold: i32) -> i32 {
    let mut graph: Vec<HashMap<i32, i32>> = vec![HashMap::new(); n as usize];
    for edge in edges {
        graph[edge[0] as usize].insert(edge[1], edge[2]);
        graph[edge[1] as usize].insert(edge[0], edge[2]);
    }

    let mut result = n;
    let mut min_neighbors = n;

    for i in 0..n {
        let mut dist = vec![i32::MAX; n as usize];
        dist[i as usize] = 0;
        let mut pq = BinaryHeap::new();
        pq.push((0, i));

        while let Some((d, u)) = pq.pop() {
            let d = -d;
            if d > dist[u as usize] {
                continue;
            }
            for (&v, &w) in graph[u as usize].iter() {
                if dist[u as usize] + w < dist[v as usize] {
                    dist[v as usize] = dist[u as usize] + w;
                    pq.push((-dist[v as usize], v));
                }
            }
        }

        let count = dist.iter().filter(|&&d| d <= distance_threshold).count() as i32;
        if count <= min_neighbors {
            min_neighbors = count;
            result = i;
        }
    }

    result
}