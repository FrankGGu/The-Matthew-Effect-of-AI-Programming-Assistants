use std::collections::VecDeque;

pub fn has_valid_path(grid: Vec<Vec<i32>>) -> bool {
    let m = grid.len();
    let n = grid[0].len();
    let directions: Vec<(i32, i32)> = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
    let valid_moves: Vec<Vec<(i32, i32)>> = vec![
        vec![(0, 1), (0, -1)],        // 1
        vec![(1, 0), (-1, 0)],       // 2
        vec![(0, 1), (1, 0)],        // 3
        vec![(0, -1), (1, 0)],       // 4
        vec![(0, 1), (-1, 0)],       // 5
        vec![(0, -1), (-1, 0)],      // 6
    ];

    let mut queue = VecDeque::new();
    let mut visited = vec![vec![false; n]; m];

    queue.push_back((0, 0));
    visited[0][0] = true;

    while let Some((x, y)) = queue.pop_front() {
        if x == m - 1 && y == n - 1 {
            return true;
        }

        for &(dx, dy) in &directions {
            let nx = x as i32 + dx;
            let ny = y as i32 + dy;

            if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                let next_cell = grid[nx as usize][ny as usize];
                let curr_cell = grid[x][y];

                if !visited[nx as usize][ny as usize] && valid_moves[curr_cell as usize - 1].iter().any(|&d| d == (dx, dy)) && 
                   valid_moves[next_cell as usize - 1].iter().any(|&d| d == (-dx, -dy)) {
                    visited[nx as usize][ny as usize] = true;
                    queue.push_back((nx as usize, ny as usize));
                }
            }
        }
    }

    false
}