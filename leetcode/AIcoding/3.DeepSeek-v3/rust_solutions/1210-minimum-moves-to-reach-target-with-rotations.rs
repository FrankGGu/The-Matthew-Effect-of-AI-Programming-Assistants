use std::collections::{HashSet, VecDeque};

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq)]
struct Position {
    x1: i32,
    y1: i32,
    x2: i32,
    y2: i32,
}

impl Position {
    fn new(x1: i32, y1: i32, x2: i32, y2: i32) -> Self {
        Position { x1, y1, x2, y2 }
    }
}

pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
    let n = grid.len() as i32;
    let start = Position::new(0, 0, 0, 1);
    let target = Position::new(n - 1, n - 2, n - 1, n - 1);
    let mut visited = HashSet::new();
    let mut queue = VecDeque::new();
    queue.push_back((start, 0));
    visited.insert(start);

    while let Some((pos, steps)) = queue.pop_front() {
        if pos == target {
            return steps;
        }

        let mut next_positions = Vec::new();

        // Move right
        if pos.y2 + 1 < n && grid[pos.x2 as usize][(pos.y2 + 1) as usize] == 0 {
            if pos.x1 == pos.x2 {
                next_positions.push(Position::new(pos.x1, pos.y1 + 1, pos.x2, pos.y2 + 1));
            } else if pos.y1 == pos.y2 && grid[pos.x1 as usize][(pos.y1 + 1) as usize] == 0 {
                next_positions.push(Position::new(pos.x1, pos.y1 + 1, pos.x2, pos.y2 + 1));
            }
        }

        // Move down
        if pos.x2 + 1 < n && grid[(pos.x2 + 1) as usize][pos.y2 as usize] == 0 {
            if pos.y1 == pos.y2 {
                next_positions.push(Position::new(pos.x1 + 1, pos.y1, pos.x2 + 1, pos.y2));
            } else if pos.x1 == pos.x2 && grid[(pos.x1 + 1) as usize][pos.y1 as usize] == 0 {
                next_positions.push(Position::new(pos.x1 + 1, pos.y1, pos.x2 + 1, pos.y2));
            }
        }

        // Rotate clockwise
        if pos.x1 == pos.x2 && pos.x1 + 1 < n && pos.y1 + 1 < n {
            if grid[(pos.x1 + 1) as usize][pos.y1 as usize] == 0 && grid[(pos.x2 + 1) as usize][pos.y2 as usize] == 0 {
                next_positions.push(Position::new(pos.x1, pos.y1, pos.x1 + 1, pos.y1));
            }
        }

        // Rotate counter-clockwise
        if pos.y1 == pos.y2 && pos.y1 + 1 < n && pos.x1 + 1 < n {
            if grid[pos.x1 as usize][(pos.y1 + 1) as usize] == 0 && grid[pos.x2 as usize][(pos.y2 + 1) as usize] == 0 {
                next_positions.push(Position::new(pos.x1, pos.y1, pos.x1, pos.y1 + 1));
            }
        }

        for next_pos in next_positions {
            if !visited.contains(&next_pos) {
                visited.insert(next_pos);
                queue.push_back((next_pos, steps + 1));
            }
        }
    }

    -1
}