struct Solution;

impl Solution {
    const UNKNOWN: i32 = 0;
    const MOUSE_WINS: i32 = 1;
    const CAT_WINS: i32 = 2;
    const DRAW: i32 = 3;

    const MOUSE_TURN: usize = 0;
    const CAT_TURN: usize = 1;

    const DR: [i32; 4] = [-1, 1, 0, 0];
    const DC: [i32; 4] = [0, 0, -1, 1];

    fn solve(
        mr: usize, mc: usize, cr: usize, cc: usize,
        turn: usize, moves_count: usize,
        rows: usize, cols: usize,
        food_r: usize, food_c: usize,
        mouse_jump: i32, cat_jump: i32,
        grid: &Vec<Vec<char>>,
        dp: &mut Vec<Vec<Vec<Vec<i32>>>>,
        max_moves_bound: usize,
    ) -> i32 {
        let mouse_idx = mr * cols + mc;
        let cat_idx = cr * cols + cc;

        if dp[mouse_idx][cat_idx][turn][moves_count] != Self::UNKNOWN {
            return dp[mouse_idx][cat_idx][turn][moves_count];
        }

        if mr == cr && mc == cc {
            dp[mouse_idx][cat_idx][turn][moves_count] = Self::CAT_WINS;
            return Self::CAT_WINS;
        }
        if mr == food_r && mc == food_c {
            dp[mouse_idx][cat_idx][turn][moves_count] = Self::MOUSE_WINS;
            return Self::MOUSE_WINS;
        }
        if cr == food_r && cc == food_c {
            dp[mouse_idx][cat_idx][turn][moves_count] = Self::CAT_WINS;
            return Self::CAT_WINS;
        }
        if moves_count >= max_moves_bound {
            dp[mouse_idx][cat_idx][turn][moves_count] = Self::DRAW;
            return Self::DRAW;
        }

        dp[mouse_idx][cat_idx][turn][moves_count] = Self::DRAW;

        if turn == Self::MOUSE_TURN {
            let mut mouse_can_win = false;
            let mut mouse_can_draw = false;

            let next_state_result = Self::solve(
                mr, mc, cr, cc, Self::CAT_TURN, moves_count + 1,
                rows, cols, food_r, food_c, mouse_jump, cat_jump, grid, dp, max_moves_bound,
            );
            if next_state_result == Self::MOUSE_WINS {
                mouse_can_win = true;
            } else if next_state_result == Self::DRAW {
                mouse_can_draw = true;
            }

            for i in 0..4 {
                for jump in 1..=(mouse_jump as usize) {
                    let nmr = mr as i32 + Self::DR[i] * jump as i32;
                    let nmc = mc as i32 + Self::DC[i] * jump as i32;

                    if nmr < 0 || nmr >= rows as i32 || nmc < 0 || nmc >= cols as i32 {
                        break;
                    }
                    if grid[nmr as usize][nmc as usize] == '#' {
                        break;
                    }

                    let next_state_result = Self::solve(
                        nmr as usize, nmc as usize, cr, cc, Self::CAT_TURN, moves_count + 1,
                        rows, cols, food_r, food_c, mouse_jump, cat_jump, grid, dp, max_moves_bound,
                    );

                    if next_state_result == Self::MOUSE_WINS {
                        mouse_can_win = true;
                        break;
                    } else if next_state_result == Self::DRAW {
                        mouse_can_draw = true;
                    }
                }
                if mouse_can_win { break; }
            }

            let result = if mouse_can_win {
                Self::MOUSE_WINS
            } else if mouse_can_draw {
                Self::DRAW
            } else {
                Self::CAT_WINS
            };
            dp[mouse_idx][cat_idx][turn][moves_count] = result;
            result

        } else {
            let mut cat_can_win = false;
            let mut cat_can_draw = false;

            let next_state_result = Self::solve(
                mr, mc, cr, cc, Self::MOUSE_TURN, moves_count + 1,
                rows, cols, food_r, food_c, mouse_jump, cat_jump, grid, dp, max_moves_bound,
            );
            if next_state_result == Self::CAT_WINS {
                cat_can_win = true;
            } else if next_state_result == Self::DRAW {
                cat_can_draw = true;
            }

            for i in 0..4 {
                for jump in 1..=(cat_jump as usize) {
                    let ncr = cr as i32 + Self::DR[i] * jump as i32;
                    let ncc = cc as i32 + Self::DC[i] * jump as i32;

                    if ncr < 0 || ncr >= rows as i32 || ncc < 0 || ncc >= cols as i32 {
                        break;
                    }
                    if grid[ncr as usize][ncc as usize] == '#' {
                        break;
                    }

                    let next_state_result = Self::solve(
                        mr, mc, ncr as usize, ncc as usize, Self::MOUSE_TURN, moves_count + 1,
                        rows, cols, food_r, food_c, mouse_jump, cat_jump, grid, dp, max_moves_bound,
                    );

                    if next_state_result == Self::CAT_WINS {
                        cat_can_win = true;
                        break;
                    } else if next_state_result == Self::DRAW {
                        cat_can_draw = true;
                    }
                }
                if cat_can_win { break; }
            }

            let result = if cat_can_win {
                Self::CAT_WINS
            } else if cat_can_draw {
                Self::DRAW
            } else {
                Self::MOUSE_WINS
            };
            dp[mouse_idx][cat_idx][turn][moves_count] = result;
            result
        }
    }

    pub fn can_mouse_win(grid: Vec<String>, cat_jump: i32, mouse_jump: i32) -> bool {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut mouse_start_r = 0;
        let mut mouse_start_c = 0;
        let mut cat_start_r = 0;
        let mut cat_start_c = 0;
        let mut food_r = 0;
        let mut food_c = 0;

        let mut char_grid: Vec<Vec<char>> = Vec::with_capacity(rows);
        for r in 0..rows {
            let row_chars: Vec<char> = grid[r].chars().collect();
            for c in 0..cols {
                match row_chars[c] {
                    'M' => { mouse_start_r = r; mouse_start_c = c; }
                    'C' => { cat_start_r = r; cat_start_c = c; }
                    'F' => { food_r = r; food_c = c; }
                    _ => {}
                }
            }
            char_grid.push(row_chars);
        }

        let n_cells = rows * cols;
        let max_moves_bound = 2 * n_cells;

        let mut dp = vec![
            vec![
                vec![
                    vec![Self::UNKNOWN; max_moves_bound + 1];
                    2
                ];
                n_cells
            ];
            n_cells
        ];

        let result = Self::solve(
            mouse_start_r, mouse_start_c,
            cat_start_r, cat_start_c,
            Self::MOUSE_TURN, 0,
            rows, cols,
            food_r, food_c,
            mouse_jump, cat_jump,
            &char_grid,
            &mut dp,
            max_moves_bound,
        );

        result == Self::MOUSE_WINS
    }
}