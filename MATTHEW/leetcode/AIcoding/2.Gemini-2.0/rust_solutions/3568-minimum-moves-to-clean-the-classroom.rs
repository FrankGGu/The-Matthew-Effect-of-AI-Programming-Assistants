use std::collections::VecDeque;

impl Solution {
    pub fn minimum_moves(classroom: Vec<Vec<i32>>) -> i32 {
        let m = classroom.len();
        let n = classroom[0].len();

        let mut start_x = 0;
        let mut start_y = 0;
        for i in 0..m {
            for j in 0..n {
                if classroom[i][j] == 1 {
                    start_x = i;
                    start_y = j;
                    break;
                }
            }
        }

        let mut q = VecDeque::new();
        q.push_back((start_x, start_y, 0));

        let mut visited = vec![vec![false; n]; m];
        visited[start_x][start_y] = true;

        let dx = [0, 0, 1, -1];
        let dy = [1, -1, 0, 0];

        while !q.is_empty() {
            let (x, y, steps) = q.pop_front().unwrap();

            if classroom[x][y] == 2 {
                return steps;
            }

            for i in 0..4 {
                let nx = x + dx[i];
                let ny = y + dy[i];

                if nx >= 0 && nx < m && ny >= 0 && ny < n && classroom[nx][ny] != 3 && !visited[nx][ny] {
                    q.push_back((nx, ny, steps + 1));
                    visited[nx][ny] = true;
                }
            }
        }

        -1
    }
}