impl Solution {

use std::collections::{HashSet, VecDeque};

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
    x: i32,
    y: i32,
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Bomb {
    x: i32,
    y: i32,
    r: i32,
}

impl Solution {
    pub fn maximum_bombs(bombs: Vec<Vec<i32>>) -> i32 {
        let n = bombs.len();
        let mut graph = vec![vec![]; n];

        for i in 0..n {
            let (x1, y1, r1) = (bombs[i][0], bombs[i][1], bombs[i][2]);
            for j in 0..n {
                if i == j {
                    continue;
                }
                let (x2, y2) = (bombs[j][0], bombs[j][1]);
                let dx = x1 - x2;
                let dy = y1 - y2;
                let dist_sq = dx * dx + dy * dy;
                if dist_sq <= r1 * r1 {
                    graph[i].push(j);
                }
            }
        }

        let mut max_count = 0;

        for i in 0..n {
            let mut visited = HashSet::new();
            let mut queue = VecDeque::new();
            queue.push_back(i);
            visited.insert(i);

            while let Some(node) = queue.pop_front() {
                for &neighbor in &graph[node] {
                    if !visited.contains(&neighbor) {
                        visited.insert(neighbor);
                        queue.push_back(neighbor);
                    }
                }
            }

            max_count = max_count.max(visited.len() as i32);
        }

        max_count
    }
}
}