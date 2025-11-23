use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Copy, Clone, Eq, PartialEq)]
struct State {
    cost: i32,
    row: usize,
    col: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
            .then_with(|| self.row.cmp(&other.row))
            .then_with(|| self.col.cmp(&other.col))
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn min_cost_to_reach_every_position(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX; cols]; rows];
        let mut pq = BinaryHeap::new();

        dist[0][0] = grid[0][0];
        pq.push(State { cost: grid[0][0], row: 0, col: 0 });

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some(State { cost, row, col }) = pq.pop() {
            if cost > dist[row][col] {
                continue;
            }

            for i in 0..4 {
                let nr = row as isize + dr[i];
                let nc = col as isize + dc[i];

                if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    let new_cost = cost + grid[nr][nc];

                    if new_cost < dist[nr][nc] {
                        dist[nr][nc] = new_cost;
                        pq.push(State { cost: new_cost, row: nr, col: nc });
                    }
                }
            }
        }

        let mut total_min_cost: i64 = 0;
        for r in 0..rows {
            for c in 0..cols {
                if dist[r][c] == i32::MAX {
                    return -1;
                }
                total_min_cost += dist[r][c] as i64;
            }
        }

        total_min_cost as i32
    }
}