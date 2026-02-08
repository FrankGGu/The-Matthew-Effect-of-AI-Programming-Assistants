use std::collections::HashMap;

impl Solution {
    pub fn maximal_path_quality(values: Vec<i32>, edges: Vec<Vec<i32>>, max_time: i32) -> i32 {
        let n = values.len();
        let mut graph: Vec<HashMap<usize, i32>> = vec![HashMap::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let time = edge[2];
            graph[u].insert(v, time);
            graph[v].insert(u, time);
        }

        let mut max_quality = 0;
        let mut visited = vec![0; n];
        visited[0] += 1;
        Self::dfs(0, &graph, &values, max_time, 0, values[0], &mut visited, &mut max_quality);
        max_quality
    }

    fn dfs(
        node: usize,
        graph: &Vec<HashMap<usize, i32>>,
        values: &Vec<i32>,
        remaining_time: i32,
        current_quality: i32,
        total_quality: i32,
        visited: &mut Vec<i32>,
        max_quality: &mut i32,
    ) {
        if node == 0 {
            *max_quality = (*max_quality).max(total_quality);
        }

        for (&neighbor, &time) in graph[node].iter() {
            if time > remaining_time {
                continue;
            }
            let was_visited = visited[neighbor] > 0;
            let new_quality = if was_visited {
                current_quality
            } else {
                current_quality + values[neighbor]
            };
            visited[neighbor] += 1;
            Self::dfs(
                neighbor,
                graph,
                values,
                remaining_time - time,
                new_quality,
                total_quality.max(new_quality),
                visited,
                max_quality,
            );
            visited[neighbor] -= 1;
        }
    }
}