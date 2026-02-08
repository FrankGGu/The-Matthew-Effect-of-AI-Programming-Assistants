use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_effort_path(heights: Vec<Vec<i32>>) -> i32 {
        let rows = heights.len();
        let cols = heights[0].len();
        let mut min_effort = vec![vec![i32::MAX; cols]; rows];
        min_effort[0][0] = 0;

        let mut heap = BinaryHeap::new();
        heap.push((0, 0, 0)); // (effort, row, col)

        while let Some((effort, x, y)) = heap.pop() {
            let effort = -effort;

            if x == rows - 1 && y == cols - 1 {
                return effort;
            }

            for (dx, dy) in &[(1, 0), (-1, 0), (0, 1), (0, -1)] {
                let new_x = (x as isize + dx) as usize;
                let new_y = (y as isize + dy) as usize;

                if new_x < rows && new_y < cols {
                    let new_effort = (heights[x][y] - heights[new_x][new_y]).abs();
                    let max_effort = effort.max(new_effort);

                    if max_effort < min_effort[new_x][new_y] {
                        min_effort[new_x][new_y] = max_effort;
                        heap.push((-max_effort, new_x, new_y));
                    }
                }
            }
        }

        0
    }
}