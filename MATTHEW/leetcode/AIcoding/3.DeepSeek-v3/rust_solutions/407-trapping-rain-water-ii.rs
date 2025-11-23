use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn trap_rain_water(height_map: Vec<Vec<i32>>) -> i32 {
        if height_map.is_empty() || height_map[0].is_empty() {
            return 0;
        }
        let m = height_map.len();
        let n = height_map[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut heap = BinaryHeap::new();

        for i in 0..m {
            visited[i][0] = true;
            visited[i][n - 1] = true;
            heap.push(Reverse((height_map[i][0], i, 0)));
            heap.push(Reverse((height_map[i][n - 1], i, n - 1)));
        }
        for j in 1..n - 1 {
            visited[0][j] = true;
            visited[m - 1][j] = true;
            heap.push(Reverse((height_map[0][j], 0, j)));
            heap.push(Reverse((height_map[m - 1][j], m - 1, j)));
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut res = 0;
        while let Some(Reverse((h, x, y))) = heap.pop() {
            for (dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if !visited[nx][ny] {
                        visited[nx][ny] = true;
                        res += 0.max(h - height_map[nx][ny]);
                        heap.push(Reverse((h.max(height_map[nx][ny]), nx, ny)));
                    }
                }
            }
        }
        res
    }
}