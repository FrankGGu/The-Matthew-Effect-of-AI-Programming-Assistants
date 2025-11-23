use std::collections::{BinaryHeap, HashSet};

impl Solution {
    pub fn min_cost(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut costs = vec![vec![i32::MAX; n]; m];
        let mut min_heap = BinaryHeap::new();
        costs[0][0] = 0;
        min_heap.push((0, 0, 0)); // (cost, x, y)

        while let Some((cost, x, y)) = min_heap.pop() {
            let cost = -cost;
            if x == m - 1 && y == n - 1 {
                return cost;
            }
            if cost > costs[x][y] {
                continue;
            }

            for (dx, dy, dir) in [(0, 1, 1), (1, 0, 2), (0, -1, 3), (-1, 0, 4)] {
                let new_x = x as isize + dx;
                let new_y = y as isize + dy;
                if new_x >= 0 && new_x < m as isize && new_y >= 0 && new_y < n as isize {
                    let new_cost = if (dir == grid[x][y]) { cost } else { cost + 1 };
                    let new_x = new_x as usize;
                    let new_y = new_y as usize;
                    if new_cost < costs[new_x][new_y] {
                        costs[new_x][new_y] = new_cost;
                        min_heap.push((-new_cost, new_x, new_y));
                    }
                }
            }
        }
        0
    }
}