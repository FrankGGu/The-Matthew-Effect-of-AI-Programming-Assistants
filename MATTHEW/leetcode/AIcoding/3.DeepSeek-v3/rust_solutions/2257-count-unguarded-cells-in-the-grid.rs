impl Solution {
    pub fn count_unguarded(m: i32, n: i32, guards: Vec<Vec<i32>>, walls: Vec<Vec<i32>>) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let mut grid = vec![vec![0; n]; m];
        let mut guarded = vec![vec![false; n]; m];

        for wall in walls {
            let x = wall[0] as usize;
            let y = wall[1] as usize;
            grid[x][y] = 1;
        }

        for guard in guards {
            let x = guard[0] as usize;
            let y = guard[1] as usize;
            grid[x][y] = 2;
        }

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        for guard in guards {
            let x = guard[0] as usize;
            let y = guard[1] as usize;

            for dir in &directions {
                let mut nx = x as i32 + dir.0;
                let mut ny = y as i32 + dir.1;

                while nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx_usize = nx as usize;
                    let ny_usize = ny as usize;

                    if grid[nx_usize][ny_usize] == 1 || grid[nx_usize][ny_usize] == 2 {
                        break;
                    }

                    guarded[nx_usize][ny_usize] = true;
                    nx += dir.0;
                    ny += dir.1;
                }
            }
        }

        let mut count = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 && !guarded[i][j] {
                    count += 1;
                }
            }
        }

        count
    }
}