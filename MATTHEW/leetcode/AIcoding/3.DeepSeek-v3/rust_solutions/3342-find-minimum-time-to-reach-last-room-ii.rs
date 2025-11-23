use std::collections::VecDeque;

impl Solution {
    pub fn find_min_time(rooms: Vec<Vec<i32>>) -> i32 {
        let n = rooms.len();
        let m = rooms[0].len();
        let mut visited = vec![vec![false; m]; n];
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 0));
        visited[0][0] = true;

        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((i, j, time)) = queue.pop_front() {
            if i == n - 1 && j == m - 1 {
                return time;
            }

            for &(di, dj) in &dirs {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;

                if ni >= 0 && ni < n as i32 && nj >= 0 && nj < m as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;

                    if !visited[ni][nj] && rooms[ni][nj] <= time + 1 {
                        visited[ni][nj] = true;
                        queue.push_back((ni, nj, time + 1));
                    }
                }
            }
        }

        -1
    }
}