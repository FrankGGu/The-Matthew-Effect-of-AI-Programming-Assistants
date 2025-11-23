use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn time_taken(edges: Vec<Vec<i32>>, n: i32, start: i32, time: Vec<i32>) -> Vec<i32> {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in &edges {
            adj.entry(edge[0]).or_insert(Vec::new()).push(edge[1]);
            adj.entry(edge[1]).or_insert(Vec::new()).push(edge[0]);
        }

        let mut result = vec![0; n as usize];
        let mut visited = vec![false; n as usize];
        let mut q = VecDeque::new();
        q.push_back((start, 0));
        visited[start as usize] = true;

        while let Some((node, current_time)) = q.pop_front() {
            result[node as usize] = current_time;

            if let Some(neighbors) = adj.get(&node) {
                for &neighbor in neighbors {
                    if !visited[neighbor as usize] {
                        visited[neighbor as usize] = true;
                        q.push_back((neighbor, current_time + time[node as usize] ));
                    }
                }
            }
        }

        result
    }
}