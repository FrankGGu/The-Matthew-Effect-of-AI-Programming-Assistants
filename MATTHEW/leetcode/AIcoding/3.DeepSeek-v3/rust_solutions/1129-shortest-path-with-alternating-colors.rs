use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn shortest_alternating_paths(n: i32, red_edges: Vec<Vec<i32>>, blue_edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![HashMap::new(); n];

        for edge in red_edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].entry(v).or_insert(vec![]).push(0);
        }

        for edge in blue_edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].entry(v).or_insert(vec![]).push(1);
        }

        let mut dist = vec![vec![-1; 2]; n];
        let mut queue = VecDeque::new();

        dist[0][0] = 0;
        dist[0][1] = 0;
        queue.push_back((0, 0));
        queue.push_back((0, 1));

        while let Some((node, color)) = queue.pop_front() {
            for (&neighbor, colors) in &graph[node] {
                for &next_color in colors {
                    if next_color != color && dist[neighbor][next_color as usize] == -1 {
                        dist[neighbor][next_color as usize] = dist[node][color as usize] + 1;
                        queue.push_back((neighbor, next_color));
                    }
                }
            }
        }

        (0..n).map(|i| {
            let d0 = dist[i][0];
            let d1 = dist[i][1];
            if d0 != -1 && d1 != -1 {
                d0.min(d1)
            } else {
                d0.max(d1)
            }
        }).collect()
    }
}