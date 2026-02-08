use std::collections::HashSet;

impl Solution {
    pub fn maximum_detonation(bombs: Vec<Vec<i32>>) -> i32 {
        let n = bombs.len();
        let mut graph = vec![vec![]; n];

        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }
                let (x1, y1, r1) = (bombs[i][0], bombs[i][1], bombs[i][2]);
                let (x2, y2, _) = (bombs[j][0], bombs[j][1], bombs[j][2]);
                let dx = x1 - x2;
                let dy = y1 - y2;
                if (dx as i64).pow(2) + (dy as i64).pow(2) <= (r1 as i64).pow(2) {
                    graph[i].push(j);
                }
            }
        }

        let mut max_detonated = 0;

        for i in 0..n {
            let mut visited = HashSet::new();
            let mut stack = vec![i];
            visited.insert(i);

            while let Some(node) = stack.pop() {
                for &neighbor in &graph[node] {
                    if !visited.contains(&neighbor) {
                        visited.insert(neighbor);
                        stack.push(neighbor);
                    }
                }
            }

            max_detonated = max_detonated.max(visited.len() as i32);
        }

        max_detonated
    }
}