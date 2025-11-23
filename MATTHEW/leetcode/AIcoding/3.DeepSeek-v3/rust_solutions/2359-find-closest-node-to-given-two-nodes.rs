use std::collections::HashMap;

impl Solution {
    pub fn closest_meeting_node(edges: Vec<i32>, node1: i32, node2: i32) -> i32 {
        let n = edges.len();
        let mut dist1 = vec![-1; n];
        let mut dist2 = vec![-1; n];

        Self::bfs(node1 as usize, &edges, &mut dist1);
        Self::bfs(node2 as usize, &edges, &mut dist2);

        let mut min_dist = i32::MAX;
        let mut result = -1;

        for i in 0..n {
            if dist1[i] != -1 && dist2[i] != -1 {
                let current_max = std::cmp::max(dist1[i], dist2[i]);
                if current_max < min_dist {
                    min_dist = current_max;
                    result = i as i32;
                }
            }
        }

        result
    }

    fn bfs(start: usize, edges: &Vec<i32>, dist: &mut Vec<i32>) {
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(start);
        dist[start] = 0;

        while let Some(node) = queue.pop_front() {
            let neighbor = edges[node] as usize;
            if neighbor != node && edges[node] != -1 && dist[neighbor] == -1 {
                dist[neighbor] = dist[node] + 1;
                queue.push_back(neighbor);
            }
        }
    }
}