use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn can_mouse_win(grid: Vec<String>, cat_jump: i32, mouse_jump: i32) -> bool {
        let grid: Vec<Vec<char>> = grid.into_iter().map(|s| s.chars().collect()).collect();
        let rows = grid.len();
        let cols = grid[0].len();
        let mut cat_pos = (0, 0);
        let mut mouse_pos = (0, 0);
        let mut food_pos = (0, 0);

        for i in 0..rows {
            for j in 0..cols {
                match grid[i][j] {
                    'C' => cat_pos = (i as i32, j as i32),
                    'M' => mouse_pos = (i as i32, j as i32),
                    'F' => food_pos = (i as i32, j as i32),
                    _ => (),
                }
            }
        }

        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut dp = vec![vec![vec![vec![vec![0; 2]; 8]; 8]; 8]; 8];

        for i in 0..8 {
            for j in 0..8 {
                for k in 0..8 {
                    for l in 0..8 {
                        dp[i][j][k][l][0] = -1;
                        dp[i][j][k][l][1] = -1;
                    }
                }
            }
        }

        fn dfs(
            mouse_x: i32,
            mouse_y: i32,
            cat_x: i32,
            cat_y: i32,
            turn: usize,
            grid: &Vec<Vec<char>>,
            rows: usize,
            cols: usize,
            cat_jump: i32,
            mouse_jump: i32,
            food_pos: (i32, i32),
            dp: &mut Vec<Vec<Vec<Vec<Vec<i32>>>>>,
            dirs: &[(i32, i32); 4],
        ) -> bool {
            if turn >= 1000 {
                return false;
            }
            if mouse_x == cat_x && mouse_y == cat_y {
                return false;
            }
            if mouse_x == food_pos.0 && mouse_y == food_pos.1 {
                return true;
            }
            if cat_x == food_pos.0 && cat_y == food_pos.1 {
                return false;
            }

            let mx = mouse_x as usize;
            let my = mouse_y as usize;
            let cx = cat_x as usize;
            let cy = cat_y as usize;
            let t = turn % 2;

            if dp[mx][my][cx][cy][t] != -1 {
                return dp[mx][my][cx][cy][t] == 1;
            }

            if t == 0 {
                for &(dx, dy) in dirs.iter() {
                    for jump in 0..=mouse_jump {
                        let new_x = mouse_x + dx * jump;
                        let new_y = mouse_y + dy * jump;
                        if new_x < 0 || new_x >= rows as i32 || new_y < 0 || new_y >= cols as i32 {
                            break;
                        }
                        if grid[new_x as usize][new_y as usize] == '#' {
                            break;
                        }
                        if dfs(
                            new_x,
                            new_y,
                            cat_x,
                            cat_y,
                            turn + 1,
                            grid,
                            rows,
                            cols,
                            cat_jump,
                            mouse_jump,
                            food_pos,
                            dp,
                            dirs,
                        ) {
                            dp[mx][my][cx][cy][t] = 1;
                            return true;
                        }
                    }
                }
                dp[mx][my][cx][cy][t] = 0;
                false
            } else {
                for &(dx, dy) in dirs.iter() {
                    for jump in 0..=cat_jump {
                        let new_x = cat_x + dx * jump;
                        let new_y = cat_y + dy * jump;
                        if new_x < 0 || new_x >= rows as i32 || new_y < 0 || new_y >= cols as i32 {
                            break;
                        }
                        if grid[new_x as usize][new_y as usize] == '#' {
                            break;
                        }
                        if !dfs(
                            mouse_x,
                            mouse_y,
                            new_x,
                            new_y,
                            turn + 1,
                            grid,
                            rows,
                            cols,
                            cat_jump,
                            mouse_jump,
                            food_pos,
                            dp,
                            dirs,
                        ) {
                            dp[mx][my][cx][cy][t] = 0;
                            return false;
                        }
                    }
                }
                dp[mx][my][cx][cy][t] = 1;
                true
            }
        }

        dfs(
            mouse_pos.0,
            mouse_pos.1,
            cat_pos.0,
            cat_pos.1,
            0,
            &grid,
            rows,
            cols,
            cat_jump,
            mouse_jump,
            food_pos,
            &mut dp,
            &dirs,
        )
    }
}