use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn shortest_alternating_paths(n: i32, red_edges: Vec<Vec<i32>>, blue_edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut red_graph: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut blue_graph: HashMap<i32, Vec<i32>> = HashMap::new();

        for edge in &red_edges {
            red_graph.entry(edge[0]).or_insert(Vec::new()).push(edge[1]);
        }
        for edge in &blue_edges {
            blue_graph.entry(edge[0]).or_insert(Vec::new()).push(edge[1]);
        }

        let mut dist = vec![-1; n as usize];
        dist[0] = 0;

        let mut queue: VecDeque<(i32, i32, i32)> = VecDeque::new();
        queue.push_back((0, 0, -1)); 

        while let Some((node, steps, prev_color)) = queue.pop_front() {
            if prev_color != 0 {
                if let Some(neighbors) = red_graph.get(&node) {
                    for &neighbor in neighbors {
                        if dist[neighbor as usize] == -1 {
                            dist[neighbor as usize] = steps + 1;
                            queue.push_back((neighbor, steps + 1, 0));
                        }
                    }
                }
            }
            if prev_color != 1 {
                if let Some(neighbors) = blue_graph.get(&node) {
                    for &neighbor in neighbors {
                        if dist[neighbor as usize] == -1 {
                            dist[neighbor as usize] = steps + 1;
                            queue.push_back((neighbor, steps + 1, 1));
                        }
                    }
                }
            }
        }

        dist
    }
}

struct Solution;