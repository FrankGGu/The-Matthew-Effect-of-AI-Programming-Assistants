impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn bubble_sort_game(mut grid: Vec<Vec<char>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut count = 0;

        loop {
            let mut removed = HashSet::new();
            for r in 0..rows {
                for c in 0..cols {
                    if grid[r][c] != ' ' && is_same(grid[r][c], &grid, r, c) {
                        mark(&mut removed, r, c);
                    }
                }
            }

            if removed.is_empty() {
                break;
            }

            count += removed.len();

            for (r, c) in &removed {
                grid[*r][*c] = ' ';
            }

            drop_bubbles(&mut grid);
        }

        count
    }

    fn is_same(c: char, grid: &[Vec<char>], r: usize, c: usize) -> bool {
        let mut queue = VecDeque::new();
        queue.push_back((r, c));
        let mut visited = HashSet::new();
        visited.insert((r, c));

        while let Some((x, y)) = queue.pop_front() {
            for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && ny >= 0 && nx < grid.len() as i32 && ny < grid[0].len() as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if grid[nx][ny] == c && !visited.contains(&(nx, ny)) {
                        visited.insert((nx, ny));
                        queue.push_back((nx, ny));
                    }
                }
            }
        }

        visited.len() >= 3
    }

    fn mark(removed: &mut HashSet<(usize, usize)>, r: usize, c: usize) {
        let mut queue = VecDeque::new();
        queue.push_back((r, c));
        let mut visited = HashSet::new();
        visited.insert((r, c));

        while let Some((x, y)) = queue.pop_front() {
            removed.insert((x, y));
            for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && ny >= 0 && nx < grid.len() as i32 && ny < grid[0].len() as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if grid[nx][ny] == grid[x][y] && !visited.contains(&(nx, ny)) {
                        visited.insert((nx, ny));
                        queue.push_back((nx, ny));
                    }
                }
            }
        }
    }

    fn drop_bubbles(grid: &mut Vec<Vec<char>>) {
        for c in 0..grid[0].len() {
            let mut idx = grid.len() - 1;
            for r in (0..grid.len()).rev() {
                if grid[r][c] != ' ' {
                    grid[idx][c] = grid[r][c];
                    idx -= 1;
                }
            }
            while idx >= 0 {
                grid[idx][c] = ' ';
                idx -= 1;
            }
        }
    }
}
}