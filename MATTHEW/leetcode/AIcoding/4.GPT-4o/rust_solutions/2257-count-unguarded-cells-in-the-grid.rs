pub fn count_unguarded(m: i32, n: i32, guards: Vec<Vec<i32>>, walls: Vec<Vec<i32>>) -> i32 {
    let mut grid = vec![vec![0; n as usize]; m as usize];

    for wall in walls {
        grid[wall[0] as usize][wall[1] as usize] = -1;
    }

    for guard in guards {
        let (x, y) = (guard[0] as usize, guard[1] as usize);
        grid[x][y] = 1;

        for i in (x + 1)..m as usize {
            if grid[i][y] == -1 { break; }
            grid[i][y] = 1;
        }
        for i in (x as isize - 1)..=0 {
            if i < 0 || grid[i as usize][y] == -1 { break; }
            grid[i as usize][y] = 1;
        }
        for j in (y + 1)..n as usize {
            if grid[x][j] == -1 { break; }
            grid[x][j] = 1;
        }
        for j in (y as isize - 1)..=0 {
            if j < 0 || grid[x][j as usize] == -1 { break; }
            grid[x][j as usize] = 1;
        }
    }

    let mut count = 0;
    for row in grid {
        for cell in row {
            if cell == 0 {
                count += 1;
            }
        }
    }

    count
}