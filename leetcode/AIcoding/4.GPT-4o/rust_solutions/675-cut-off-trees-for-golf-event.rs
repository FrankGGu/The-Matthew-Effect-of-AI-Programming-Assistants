use std::collections::BinaryHeap;

impl Solution {
    pub fn cut_off_tree(forest: Vec<Vec<i32>>) -> i32 {
        let mut trees = Vec::new();
        let rows = forest.len();
        let cols = forest[0].len();

        for i in 0..rows {
            for j in 0..cols {
                if forest[i][j] > 1 {
                    trees.push((forest[i][j], i, j));
                }
            }
        }

        trees.sort();

        let mut total_steps = 0;
        let mut start = (0, 0);

        for (_, x, y) in trees {
            let steps = Self::bfs(&forest, start, (x, y));
            if steps < 0 {
                return -1;
            }
            total_steps += steps;
            start = (x, y);
        }

        total_steps
    }

    fn bfs(forest: &Vec<Vec<i32>>, start: (usize, usize), target: (usize, usize)) -> i32 {
        let rows = forest.len();
        let cols = forest[0].len();
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];
        let mut queue = vec![(start, 0)];
        let mut visited = vec![vec![false; cols]; rows];
        visited[start.0][start.1] = true;

        while let Some(((x, y), steps)) = queue.remove(0) {
            if (x, y) == target {
                return steps;
            }

            for (dx, dy) in &directions {
                let nx = (x as isize + dx) as usize;
                let ny = (y as isize + dy) as usize;

                if nx < rows && ny < cols && !visited[nx][ny] && forest[nx][ny] > 0 {
                    visited[nx][ny] = true;
                    queue.push(((nx, ny), steps + 1));
                }
            }
        }

        -1
    }
}