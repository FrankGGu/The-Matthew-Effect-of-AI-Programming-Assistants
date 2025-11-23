impl Solution {

use std::collections::{BinaryHeap, HashSet};

#[derive(Eq, PartialEq, Clone, Copy, Hash, Debug)]
struct Position {
    row: usize,
    col: usize,
}

#[derive(Eq, PartialEq, Clone, Copy, Hash, Debug)]
struct State {
    height: i32,
    pos: Position,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.height.cmp(&self.height)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn swim_in_rain_water(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut visited = HashSet::new();
        let mut pq = BinaryHeap::new();
        pq.push(State {
            height: grid[0][0],
            pos: Position { row: 0, col: 0 },
        });
        visited.insert(Position { row: 0, col: 0 });

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some(State { height, pos }) = pq.pop() {
            if pos.row == n - 1 && pos.col == n - 1 {
                return height;
            }
            for &(dr, dc) in &directions {
                let nr = pos.row as i32 + dr;
                let nc = pos.col as i32 + dc;
                if nr >= 0 && nr < n as i32 && nc >= 0 && nc < n as i32 {
                    let new_pos = Position {
                        row: nr as usize,
                        col: nc as usize,
                    };
                    if !visited.contains(&new_pos) {
                        visited.insert(new_pos);
                        pq.push(State {
                            height: std::cmp::max(height, grid[new_pos.row][new_pos.col]),
                            pos: new_pos,
                        });
                    }
                }
            }
        }

        -1
    }
}
}