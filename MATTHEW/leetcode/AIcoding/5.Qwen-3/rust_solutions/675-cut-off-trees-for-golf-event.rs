impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn cut_off_trees(forest: Vec<Vec<i32>>) -> i32 {
        let mut tree_positions = Vec::new();
        for (i, row) in forest.iter().enumerate() {
            for (j, &val) in row.iter().enumerate() {
                if val != 0 {
                    tree_positions.push((val, i, j));
                }
            }
        }
        tree_positions.sort();

        let mut result = 0;
        let mut current = (0, 0);
        for &(height, x, y) in &tree_positions {
            let steps = Self::bfs(&forest, current.0, current.1, x, y);
            if steps == -1 {
                return -1;
            }
            result += steps;
            current = (x, y);
        }
        result
    }

    fn bfs(forest: &Vec<Vec<i32>>, start_x: usize, start_y: usize, target_x: usize, target_y: usize) -> i32 {
        let rows = forest.len();
        let cols = forest[0].len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((start_x, start_y, 0));
        visited.insert((start_x, start_y));

        while let Some((x, y, steps)) = queue.pop_front() {
            if x == target_x && y == target_y {
                return steps;
            }
            for (dx, dy) in [(0, 1), (1, 0), (0, -1), (-1, 0)] {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && ny >= 0 && nx < rows as i32 && ny < cols as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if !visited.contains(&(nx, ny)) && forest[nx][ny] != 0 {
                        visited.insert((nx, ny));
                        queue.push_back((nx, ny, steps + 1));
                    }
                }
            }
        }
        -1
    }
}
}