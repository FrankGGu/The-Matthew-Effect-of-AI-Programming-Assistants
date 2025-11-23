impl Solution {
    pub fn check_knight_tour(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        let m = grid[0].len();

        if grid[0][0] != 0 {
            return false;
        }

        let mut pos = (0, 0);

        for i in 1..(n * m) as i32 {
            let (x, y) = pos;
            let mut found = false;
            let possible_moves = vec![
                (x as i32 + 2, y as i32 + 1),
                (x as i32 + 2, y as i32 - 1),
                (x as i32 - 2, y as i32 + 1),
                (x as i32 - 2, y as i32 - 1),
                (x as i32 + 1, y as i32 + 2),
                (x as i32 + 1, y as i32 - 2),
                (x as i32 - 1, y as i32 + 2),
                (x as i32 - 1, y as i32 - 2),
            ];

            for (nx, ny) in possible_moves {
                if nx >= 0 && nx < n as i32 && ny >= 0 && ny < m as i32 {
                    if grid[nx as usize][ny as usize] == i {
                        pos = (nx as usize, ny as usize);
                        found = true;
                        break;
                    }
                }
            }

            if !found {
                return false;
            }
        }
        true
    }
}