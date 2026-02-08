use std::collections::{BinaryHeap, HashSet};

impl Solution {
    pub fn cut_off_tree(forest: Vec<Vec<i32>>) -> i32 {
        let mut trees: Vec<(usize, usize, i32)> = Vec::new();
        let m = forest.len();
        let n = forest[0].len();

        for i in 0..m {
            for j in 0..n {
                if forest[i][j] > 1 {
                    trees.push((i, j, forest[i][j]));
                }
            }
        }

        trees.sort_by_key(|&(_, _, h)| h);

        let mut start = (0, 0);
        let mut total_steps = 0;

        for &(row, col, _) in &trees {
            let steps = Self::bfs(&forest, start, (row, col));
            if steps == -1 {
                return -1;
            }
            total_steps += steps;
            start = (row, col);
        }

        total_steps
    }

    fn bfs(forest: &Vec<Vec<i32>>, start: (usize, usize), end: (usize, usize)) -> i32 {
        let m = forest.len();
        let n = forest[0].len();
        let mut visited: HashSet<(usize, usize)> = HashSet::new();
        let mut queue: std::collections::VecDeque<((usize, usize), i32)> = std::collections::VecDeque::new();

        queue.push_back((start, 0));
        visited.insert(start);

        while let Some(((row, col), steps)) = queue.pop_front() {
            if (row, col) == end {
                return steps;
            }

            let directions: [(i32, i32); 4] = [(0, 1), (0, -1), (1, 0), (-1, 0)];

            for &(dr, dc) in &directions {
                let new_row = row as i32 + dr;
                let new_col = col as i32 + dc;

                if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                    let new_row_usize = new_row as usize;
                    let new_col_usize = new_col as usize;

                    if forest[new_row_usize][new_col_usize] > 0 && !visited.contains(&(new_row_usize, new_col_usize)) {
                        queue.push_back(((new_row_usize, new_col_usize), steps + 1));
                        visited.insert((new_row_usize, new_col_usize));
                    }
                }
            }
        }

        -1
    }
}