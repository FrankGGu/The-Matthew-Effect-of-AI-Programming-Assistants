impl Solution {
    pub fn count_unguarded(m: i32, n: i32, guards: Vec<Vec<i32>>, walls: Vec<Vec<i32>>) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let mut grid = vec![vec![0; n]; m];

        for guard in &guards {
            grid[guard[0] as usize][guard[1] as usize] = 1; // Guard
        }

        for wall in &walls {
            grid[wall[0] as usize][wall[1] as usize] = 2; // Wall
        }

        for guard in &guards {
            let r = guard[0] as usize;
            let c = guard[1] as usize;

            // Left
            for i in (0..c).rev() {
                if grid[r][i] == 1 || grid[r][i] == 2 {
                    break;
                }
                grid[r][i] = 3;
            }

            // Right
            for i in c + 1..n {
                if grid[r][i] == 1 || grid[r][i] == 2 {
                    break;
                }
                grid[r][i] = 3;
            }

            // Up
            for i in (0..r).rev() {
                if grid[i][c] == 1 || grid[i][c] == 2 {
                    break;
                }
                grid[i][c] = 3;
            }

            // Down
            for i in r + 1..m {
                if grid[i][c] == 1 || grid[i][c] == 2 {
                    break;
                }
                grid[i][c] = 3;
            }
        }

        let mut count = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 {
                    count += 1;
                }
            }
        }

        count
    }
}