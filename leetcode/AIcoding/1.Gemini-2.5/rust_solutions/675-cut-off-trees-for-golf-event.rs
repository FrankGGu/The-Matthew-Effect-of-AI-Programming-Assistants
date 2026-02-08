use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn cut_off_tree(forest: Vec<Vec<i32>>) -> i32 {
        let R = forest.len();
        if R == 0 {
            return 0;
        }
        let C = forest[0].len();
        if C == 0 {
            return 0;
        }

        let mut trees = Vec::new();
        for r in 0..R {
            for c in 0..C {
                if forest[r][c] > 1 {
                    trees.push((forest[r][c], r, c)); // (height, row, col)
                }
            }
        }

        trees.sort_unstable(); // Sorts by height by default

        let mut total_steps = 0;
        let mut current_pos = (0, 0);

        for i in 0..trees.len() {
            let target_r = trees[i].1;
            let target_c = trees[i].2;

            let steps = Self::bfs(current_pos.0, current_pos.1, target_r, target_c, &forest, R, C);

            if steps == -1 {
                return -1;
            }

            total_steps += steps;
            current_pos = (target_r, target_c);
        }

        total_steps
    }

    fn bfs(sr: usize, sc: usize, tr: usize, tc: usize, forest: &Vec<Vec<i32>>, R: usize, C: usize) -> i32 {
        if sr == tr && sc == tc {
            return 0;
        }

        let mut queue = VecDeque::new();
        let mut visited = vec![vec![false; C]; R];

        queue.push_back((sr, sc, 0)); // (row, col, steps)
        visited[sr][sc] = true;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c, steps)) = queue.pop_front() {
            for i in 0..4 {
                let nr = r as isize + dr[i];
                let nc = c as isize + dc[i];

                if nr >= 0 && nr < R as isize && nc >= 0 && nc < C as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    if !visited[nr][nc] && forest[nr][nc] != 0 {
                        if nr == tr && nc == tc {
                            return steps + 1;
                        }
                        visited[nr][nc] = true;
                        queue.push_back((nr, nc, steps + 1));
                    }
                }
            }
        }

        -1
    }
}