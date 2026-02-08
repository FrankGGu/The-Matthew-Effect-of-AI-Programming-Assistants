impl Solution {
    pub fn maximum_detonation(bombs: Vec<Vec<i32>>) -> i32 {
        let n = bombs.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];

        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }
                let dx = bombs[i][0] as i64 - bombs[j][0] as i64;
                let dy = bombs[i][1] as i64 - bombs[j][1] as i64;
                let r = bombs[i][2] as i64;
                if dx * dx + dy * dy <= r * r {
                    adj[i].push(j);
                }
            }
        }

        let mut max_detonated = 0;
        for start_node in 0..n {
            let mut visited = vec![false; n];
            let mut q = std::collections::VecDeque::new();
            q.push_back(start_node);
            visited[start_node] = true;
            let mut detonated_count = 0;

            while let Some(curr_node) = q.pop_front() {
                detonated_count += 1;
                for &neighbor in &adj[curr_node] {
                    if !visited[neighbor] {
                        visited[neighbor] = true;
                        q.push_back(neighbor);
                    }
                }
            }
            max_detonated = max_detonated.max(detonated_count);
        }

        max_detonated
    }
}