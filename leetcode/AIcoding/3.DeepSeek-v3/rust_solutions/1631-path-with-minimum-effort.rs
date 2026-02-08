use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_effort_path(heights: Vec<Vec<i32>>) -> i32 {
        let rows = heights.len();
        if rows == 0 {
            return 0;
        }
        let cols = heights[0].len();
        let mut dist = vec![vec![i32::MAX; cols]; rows];
        dist[0][0] = 0;
        let mut heap = BinaryHeap::new();
        heap.push((0, 0, 0));

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((neg_effort, x, y)) = heap.pop() {
            let current_effort = -neg_effort;
            if x == rows - 1 && y == cols - 1 {
                return current_effort;
            }
            if current_effort > dist[x][y] {
                continue;
            }
            for (dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    let new_effort = current_effort.max((heights[x][y] - heights[nx][ny]).abs());
                    if new_effort < dist[nx][ny] {
                        dist[nx][ny] = new_effort;
                        heap.push((-new_effort, nx, ny));
                    }
                }
            }
        }
        0
    }
}