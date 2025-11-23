impl Solution {
    pub fn can_mouse_win(grid: Vec<String>, cat_jump: i32, mouse_jump: i32) -> bool {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut start_mouse = (0, 0);
        let mut start_cat = (0, 0);
        let mut food = (0, 0);

        for i in 0..rows {
            for j in 0..cols {
                let c = grid[i].chars().nth(j).unwrap();
                if c == 'M' {
                    start_mouse = (i, j);
                } else if c == 'C' {
                    start_cat = (i, j);
                } else if c == 'F' {
                    food = (i, j);
                }
            }
        }

        let mut memo = std::collections::HashMap::new();

        fn solve(
            grid: &Vec<String>,
            mouse: (usize, usize),
            cat: (usize, usize),
            food: (usize, usize),
            mouse_turn: bool,
            cat_jump: i32,
            mouse_jump: i32,
            rows: usize,
            cols: usize,
            moves: i32,
            memo: &mut std::collections::HashMap<((usize, usize), (usize, usize), bool), bool>,
        ) -> bool {
            if moves > 2 * rows * cols {
                return false;
            }

            if mouse == cat {
                return false;
            }

            if mouse == food {
                return true;
            }

            if cat == food {
                return false;
            }

            if memo.contains_key(&(mouse, cat, mouse_turn)) {
                return *memo.get(&(mouse, cat, mouse_turn)).unwrap();
            }

            let mut result;

            if mouse_turn {
                let mut can_win = false;
                let jump = mouse_jump as usize;
                let r = mouse.0;
                let c = mouse.1;

                let directions = vec![(0, 1), (0, -1), (1, 0), (-1, 0), (0, 0)];

                for (dr, dc) in directions {
                    let mut nr = r;
                    let mut nc = c;
                    let mut valid = true;

                    if dr == 0 && dc == 0 {
                        if grid[nr].chars().nth(nc).unwrap() == '#' {
                            continue;
                        }
                        if solve(
                            grid,
                            (nr, nc),
                            cat,
                            food,
                            !mouse_turn,
                            cat_jump,
                            mouse_jump,
                            rows,
                            cols,
                            moves + 1,
                            memo,
                        ) {
                            can_win = true;
                            break;
                        }
                        continue;
                    }

                    for _ in 0..=jump {
                        if nr.wrapping_add(dr) >= rows || nc.wrapping_add(dc) >= cols {
                            break;
                        }

                        let new_nr = (nr as i32 + dr) as usize;
                        let new_nc = (nc as i32 + dc) as usize;

                        if grid[new_nr].chars().nth(new_nc).unwrap() == '#' {
                            break;
                        }

                        nr = new_nr;
                        nc = new_nc;

                        if solve(
                            grid,
                            (nr, nc),
                            cat,
                            food,
                            !mouse_turn,
                            cat_jump,
                            mouse_jump,
                            rows,
                            cols,
                            moves + 1,
                            memo,
                        ) {
                            can_win = true;
                            break;
                        }
                    }
                    if can_win {
                        break;
                    }
                }

                result = can_win;
            } else {
                let mut can_win = true;
                let jump = cat_jump as usize;
                let r = cat.0;
                let c = cat.1;

                let directions = vec![(0, 1), (0, -1), (1, 0), (-1, 0), (0, 0)];

                for (dr, dc) in directions {
                    let mut nr = r;
                    let mut nc = c;
                    let mut valid = true;

                    if dr == 0 && dc == 0 {
                        if grid[nr].chars().nth(nc).unwrap() == '#' {
                            continue;
                        }
                        if !solve(
                            grid,
                            mouse,
                            (nr, nc),
                            food,
                            !mouse_turn,
                            cat_jump,
                            mouse_jump,
                            rows,
                            cols,
                            moves + 1,
                            memo,
                        ) {
                            can_win = false;
                            break;
                        }
                        continue;
                    }
                    for _ in 0..=jump {
                        if nr.wrapping_add(dr) >= rows || nc.wrapping_add(dc) >= cols {
                            break;
                        }

                        let new_nr = (nr as i32 + dr) as usize;
                        let new_nc = (nc as i32 + dc) as usize;

                        if grid[new_nr].chars().nth(new_nc).unwrap() == '#' {
                            break;
                        }

                        nr = new_nr;
                        nc = new_nc;
                        if !solve(
                            grid,
                            mouse,
                            (nr, nc),
                            food,
                            !mouse_turn,
                            cat_jump,
                            mouse_jump,
                            rows,
                            cols,
                            moves + 1,
                            memo,
                        ) {
                            can_win = false;
                            break;
                        }
                    }
                    if !can_win {
                        break;
                    }
                }

                result = can_win;
            }

            memo.insert((mouse, cat, mouse_turn), result);
            result
        }

        solve(
            &grid,
            start_mouse,
            start_cat,
            food,
            true,
            cat_jump,
            mouse_jump,
            rows,
            cols,
            0,
            &mut memo,
        )
    }
}