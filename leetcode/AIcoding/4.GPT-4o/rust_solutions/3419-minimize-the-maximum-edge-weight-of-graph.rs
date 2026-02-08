use std::cmp::Ordering;
use std::collections::BinaryHeap;

pub fn minimize_max_edge_weight(n: i32, edges: Vec<Vec<i32>>) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    for edge in edges {
        graph[edge[0] as usize].push((edge[1], edge[2]));
        graph[edge[1] as usize].push((edge[0], edge[2]));
    }

    let mut left = 0;
    let mut right = edges.iter().map(|e| e[2]).max().unwrap();

    while left < right {
        let mid = (left + right) / 2;
        if can_form_path(n, &graph, mid) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    left
}

fn can_form_path(n: i32, graph: &Vec<Vec<(i32, i32)>>, max_weight: i32) -> bool {
    let mut visited = vec![false; n as usize];
    let mut pq = BinaryHeap::new();
    pq.push((std::i32::MAX, 0));

    while let Some((weight, node)) = pq.pop() {
        if visited[node as usize] {
            continue;
        }
        visited[node as usize] = true;

        for &(neighbor, edge_weight) in &graph[node as usize] {
            if !visited[neighbor as usize] && edge_weight <= max_weight {
                pq.push((weight.min(edge_weight), neighbor));
            }
        }
    }

    visited.iter().all(|&v| v)
}