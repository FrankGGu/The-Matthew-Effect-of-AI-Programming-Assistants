use std::collections::{HashMap, HashSet};

pub struct Solution;

impl Solution {
    pub fn maximum_path_quality(values: Vec<i32>, edges: Vec<Vec<i32>>, max_time: i32) -> i32 {
        let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for edge in edges {
            graph.entry(edge[0]).or_insert(Vec::new()).push((edge[1], edge[2]));
            graph.entry(edge[1]).or_insert(Vec::new()).push((edge[0], edge[2]));
        }

        let n = values.len() as i32;
        let mut max_quality = 0;

        fn dfs(
            node: i32,
            time: i32,
            current_quality: i32,
            visited: &mut HashSet<i32>,
            graph: &HashMap<i32, Vec<(i32, i32)>>,
            values: &Vec<i32>,
            max_time: i32,
            max_quality: &mut i32,
        ) {
            if time > max_time {
                return;
            }
            if visited.contains(&node) {
                return;
            }
            visited.insert(node);
            let new_quality = current_quality + values[node as usize];
            if node == 0 {
                *max_quality = (*max_quality).max(new_quality);
            }
            for &(neighbour, travel_time) in &graph[&node] {
                dfs(
                    neighbour,
                    time + travel_time,
                    new_quality,
                    visited,
                    graph,
                    values,
                    max_time,
                    max_quality,
                );
            }
            visited.remove(&node);
        }

        let mut visited = HashSet::new();
        dfs(0, 0, 0, &mut visited, &graph, &values, max_time, &mut max_quality);
        max_quality
    }
}