use std::collections::VecDeque;

impl Solution {
    pub fn highest_peak(is_water: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = is_water.len();
        let n = is_water[0].len();
        let mut height = vec![vec![-1; n]; m];
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if is_water[i][j] == 1 {
                    height[i][j] = 0;
                    queue.push_back((i, j));
                }
            }
        }

        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((x, y)) = queue.pop_front() {
            for (dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if height[nx][ny] == -1 {
                        height[nx][ny] = height[x][y] + 1;
                        queue.push_back((nx, ny));
                    }
                }
            }
        }

        height
    }
}