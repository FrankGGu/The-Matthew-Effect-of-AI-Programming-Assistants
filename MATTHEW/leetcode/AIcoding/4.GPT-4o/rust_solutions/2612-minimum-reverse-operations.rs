pub fn minimum_reverse_operations(n: i32, edges: Vec<Vec<i32>>, start: i32, end: i32) -> i32 {
    use std::collections::{HashSet, VecDeque};

    let mut graph = vec![Vec::new(); n as usize];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut dist = vec![i32::MAX; n as usize];
    dist[start as usize] = 0;

    let mut queue = VecDeque::new();
    queue.push_back(start);

    while let Some(node) = queue.pop_front() {
        for &neigh in &graph[node as usize] {
            if dist[neigh as usize] == i32::MAX {
                dist[neigh as usize] = dist[node as usize] + 1;
                queue.push_back(neigh);
            }
        }
    }

    if dist[end as usize] == i32::MAX {
        return -1;
    }

    let mut result = dist[end as usize];
    for i in 0..n {
        if dist[i as usize] != i32::MAX {
            let mut temp_dist = dist.clone();
            for &neigh in &graph[i as usize] {
                temp_dist[neigh as usize] = dist[i as usize] + 1;
            }
            result = result.min(temp_dist[end as usize]);
        }
    }

    result
}