use std::collections::VecDeque;

pub fn find_shortest_cycle(n: i32, edges: Vec<Vec<i32>>) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut shortest_cycle = std::i32::MAX;

    for start in 0..n {
        let mut dist = vec![-1; n as usize];
        let mut queue = VecDeque::new();
        queue.push_back(start);
        dist[start as usize] = 0;

        while let Some(node) = queue.pop_front() {
            for &neighbor in &graph[node as usize] {
                if dist[neighbor as usize] == -1 {
                    dist[neighbor as usize] = dist[node as usize] + 1;
                    queue.push_back(neighbor);
                } else if dist[neighbor as usize] >= dist[node as usize] {
                    shortest_cycle = shortest_cycle.min(dist[node as usize] + dist[neighbor as usize] + 1);
                }
            }
        }
    }

    if shortest_cycle == std::i32::MAX {
        -1
    } else {
        shortest_cycle
    }
}