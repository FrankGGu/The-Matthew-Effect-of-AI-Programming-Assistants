impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn max_path_quality(mut neighbors: Vec<Vec<i32>>, mut values: Vec<i32>, mut src: i32, mut dst: i32) -> i32 {
        let n = neighbors.len();
        let mut graph = HashMap::new();
        for i in 0..n {
            graph.insert(i as i32, neighbors[i].clone());
        }

        let mut max_quality = 0;
        let mut visited = vec![false; n];
        let mut path = vec![];
        let mut current_sum = 0;

        fn dfs(
            node: i32,
            graph: &HashMap<i32, Vec<i32>>,
            values: &[i32],
            visited: &mut Vec<bool>,
            path: &mut Vec<i32>,
            current_sum: i32,
            max_quality: &mut i32,
            dst: i32,
        ) {
            if node == dst {
                *max_quality = std::cmp::max(*max_quality, current_sum);
                return;
            }

            for &neighbor in graph.get(&node).unwrap() {
                if !visited[neighbor as usize] {
                    visited[neighbor as usize] = true;
                    path.push(neighbor);
                    dfs(
                        neighbor,
                        graph,
                        values,
                        visited,
                        path,
                        current_sum + values[neighbor as usize],
                        max_quality,
                        dst,
                    );
                    path.pop();
                    visited[neighbor as usize] = false;
                }
            }
        }

        visited[src as usize] = true;
        path.push(src);
        dfs(
            src,
            &graph,
            &values,
            &mut visited,
            &mut path,
            values[src as usize],
            &mut max_quality,
            dst,
        );

        max_quality
    }
}
}