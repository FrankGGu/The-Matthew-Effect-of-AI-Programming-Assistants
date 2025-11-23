use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn conveyor_belt(matrix: Vec<String>, start: Vec<i32>, end: Vec<i32>) -> i32 {
        let rows = matrix.len();
        if rows == 0 {
            return 0;
        }
        let cols = matrix[0].len();
        let mut dist = vec![vec![i32::MAX; cols]; rows];
        let mut heap = BinaryHeap::new();
        let (sx, sy) = (start[0] as usize, start[1] as usize);
        let (ex, ey) = (end[0] as usize, end[1] as usize);
        dist[sx][sy] = 0;
        heap.push(Reverse((0, sx, sy)));

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let dir_chars = ['^', 'v', '<', '>'];

        while let Some(Reverse((d, x, y))) = heap.pop() {
            if x == ex && y == ey {
                return d;
            }
            if d > dist[x][y] {
                continue;
            }
            for (i, &(dx, dy)) in dirs.iter().enumerate() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    let cost = if matrix[x].chars().nth(y).unwrap() == dir_chars[i] { 0 } else { 1 };
                    let new_dist = d + cost;
                    if new_dist < dist[nx][ny] {
                        dist[nx][ny] = new_dist;
                        heap.push(Reverse((new_dist, nx, ny)));
                    }
                }
            }
        }
        -1
    }
}