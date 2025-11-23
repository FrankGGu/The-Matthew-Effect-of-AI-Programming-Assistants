use std::collections::{BinaryHeap, VecDeque};
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct Cell {
    distance: i32,
    row: i32,
    col: i32,
}

impl Ord for Cell {
    fn cmp(&self, other: &Self) -> Ordering {
        other.distance.cmp(&self.distance)
    }
}

impl PartialOrd for Cell {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn cut_off_tree(forest: Vec<Vec<i32>>) -> i32 {
        if forest.is_empty() || forest[0].is_empty() {
            return -1;
        }

        let m = forest.len() as i32;
        let n = forest[0].len() as i32;

        let mut trees = Vec::new();
        for i in 0..m {
            for j in 0..n {
                if forest[i as usize][j as usize] > 1 {
                    trees.push((forest[i as usize][j as usize], i, j));
                }
            }
        }

        trees.sort_unstable();

        let mut sr = 0;
        let mut sc = 0;
        let mut total_steps = 0;

        for tree in trees {
            let (_, tr, tc) = tree;
            let steps = Self::bfs(&forest, sr, sc, tr, tc, m, n);
            if steps == -1 {
                return -1;
            }
            total_steps += steps;
            sr = tr;
            sc = tc;
        }

        total_steps
    }

    fn bfs(forest: &[Vec<i32>], sr: i32, sc: i32, tr: i32, tc: i32, m: i32, n: i32) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back((sr, sc, 0));
        let mut visited = vec![vec![false; n as usize]; m as usize];
        visited[sr as usize][sc as usize] = true;
        let dirs = vec![(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((r, c, steps)) = queue.pop_front() {
            if r == tr && c == tc {
                return steps;
            }

            for (dr, dc) in dirs.iter() {
                let nr = r + dr;
                let nc = c + dc;
                if nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr as usize][nc as usize] && forest[nr as usize][nc as usize] != 0 {
                    visited[nr as usize][nc as usize] = true;
                    queue.push_back((nr, nc, steps + 1));
                }
            }
        }

        -1
    }
}