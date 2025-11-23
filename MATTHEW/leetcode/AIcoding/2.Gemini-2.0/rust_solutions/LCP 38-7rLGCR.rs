impl Solution {
    pub fn guard_castle(grid: Vec<String>) -> i32 {
        let m = grid.len();
        let n = if m == 0 { 0 } else { grid[0].len() };
        if m == 0 || n == 0 {
            return 0;
        }

        let mut grid_chars: Vec<Vec<char>> = grid.iter().map(|row| row.chars().collect()).collect();

        let mut guards = 0;

        for i in 0..m {
            for j in 0..n {
                if grid_chars[i][j] == '.' {
                    let mut can_place = true;

                    // Check left
                    for k in (0..j).rev() {
                        if grid_chars[i][k] == 'B' {
                            break;
                        } else if grid_chars[i][k] == 'G' {
                            can_place = false;
                            break;
                        }
                    }
                    if !can_place {
                        continue;
                    }

                    // Check right
                    for k in (j + 1)..n {
                        if grid_chars[i][k] == 'B' {
                            break;
                        } else if grid_chars[i][k] == 'G' {
                            can_place = false;
                            break;
                        }
                    }
                    if !can_place {
                        continue;
                    }

                    // Check up
                    for k in (0..i).rev() {
                        if grid_chars[k][j] == 'B' {
                            break;
                        } else if grid_chars[k][j] == 'G' {
                            can_place = false;
                            break;
                        }
                    }
                    if !can_place {
                        continue;
                    }

                    // Check down
                    for k in (i + 1)..m {
                        if grid_chars[k][j] == 'B' {
                            break;
                        } else if grid_chars[k][j] == 'G' {
                            can_place = false;
                            break;
                        }
                    }
                    if can_place {
                        guards += 1;
                        grid_chars[i][j] = 'G';
                    }
                }
            }
        }

        guards
    }
}