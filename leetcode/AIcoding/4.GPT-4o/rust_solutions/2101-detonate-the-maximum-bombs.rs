impl Solution {
    pub fn max_detonation(bombs: Vec<Vec<i32>>) -> i32 {
        let n = bombs.len();
        let mut graph = vec![vec![]; n];

        for i in 0..n {
            for j in 0..n {
                if i != j {
                    let dx = bombs[i][0] - bombs[j][0];
                    let dy = bombs[i][1] - bombs[j][1];
                    let dist_sq = dx * dx + dy * dy;
                    let r_sq = bombs[i][2] * bombs[i][2];
                    if dist_sq <= r_sq {
                        graph[i].push(j);
                    }
                }
            }
        }

        let mut max_bombs = 0;

        for i in 0..n {
            let mut visited = vec![false; n];
            let mut count = 0;
            let mut stack = vec![i];

            while let Some(node) = stack.pop() {
                if visited[node] {
                    continue;
                }
                visited[node] = true;
                count += 1;
                for &neighbor in &graph[node] {
                    if !visited[neighbor] {
                        stack.push(neighbor);
                    }
                }
            }

            max_bombs = max_bombs.max(count);
        }

        max_bombs
    }
}