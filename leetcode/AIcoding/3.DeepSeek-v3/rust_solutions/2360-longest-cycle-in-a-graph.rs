impl Solution {
    pub fn longest_cycle(edges: Vec<i32>) -> i32 {
        let n = edges.len();
        let mut visited = vec![false; n];
        let mut max_cycle = -1;

        for i in 0..n {
            if !visited[i] {
                let mut path = std::collections::HashMap::new();
                let mut current = i;
                let mut distance = 0;

                while current != -1 {
                    if visited[current as usize] {
                        if let Some(&prev_dist) = path.get(&current) {
                            max_cycle = max_cycle.max(distance - prev_dist);
                        }
                        break;
                    }
                    visited[current as usize] = true;
                    path.insert(current, distance);
                    current = edges[current as usize];
                    distance += 1;
                }
            }
        }

        max_cycle
    }
}