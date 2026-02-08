use std::collections::VecDeque;

pub fn shortest_alternating_paths(n: i32, red_edges: Vec<Vec<i32>>, blue_edges: Vec<Vec<i32>>) -> Vec<i32> {
    let mut graph = vec![vec![vec![]; 2]; n as usize];

    for edge in red_edges {
        graph[edge[0] as usize][0].push(edge[1]);
    }

    for edge in blue_edges {
        graph[edge[0] as usize][1].push(edge[1]);
    }

    let mut dist = vec![-1; n as usize];
    dist[0] = 0;
    let mut queue = VecDeque::new();
    queue.push_back((0, 0, 0));
    queue.push_back((0, 1, 0));

    while let Some((node, color, d)) = queue.pop_front() {
        for &neighbor in &graph[node][color] {
            if dist[neighbor as usize] == -1 {
                dist[neighbor as usize] = d + 1;
                queue.push_back((neighbor, 1 - color, d + 1));
            }
        }
    }

    dist.into_iter().map(|x| x).collect()
}