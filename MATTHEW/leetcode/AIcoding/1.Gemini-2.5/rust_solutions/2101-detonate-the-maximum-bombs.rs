use std::collections::VecDeque;

impl Solution {
    pub fn maximum_detonation(bombs: Vec<Vec<i32>>) -> i32 {
        let n = bombs.len();
        if n == 0 {
            return 0;
        }

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];

        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }

                let x1 = bombs[i][0] as i64;
                let y1 = bombs[i][1] as i64;
                let r1 = bombs[i][2] as i64;

                let x2 = bombs[j][0] as i64;
                let y2 = bombs[j][1] as i64;

                let dx = x1 - x2;
                let dy = y1 - y2;
                let dist_sq = dx * dx + dy * dy;
                let r1_sq = r1 * r1;

                if dist_sq <= r1_sq {
                    adj[i].push(j);
                }
            }
        }

        let mut max_detonated = 0;

        for i in 0..n {
            let mut current_detonated = 0;
            let mut visited: Vec<bool> = vec![false; n];
            let mut q: VecDeque<usize> = VecDeque::new();

            q.push_back(i);
            visited[i] = true;
            current_detonated += 1;

            while let Some(u) = q.pop_front() {
                for &v in &adj[u] {
                    if !visited[v] {
                        visited[v] = true;
                        q.push_back(v);
                        current_detonated += 1;
                    }
                }
            }
            max_detonated = max_detonated.max(current_detonated);
        }

        max_detonated
    }
}