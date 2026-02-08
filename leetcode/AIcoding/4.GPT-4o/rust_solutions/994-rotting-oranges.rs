use std::collections::VecDeque;

pub fn oranges_rotting(grid: Vec<Vec<i32>>) -> i32 {
    let mut grid = grid;
    let mut queue = VecDeque::new();
    let mut fresh_count = 0;
    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

    for i in 0..grid.len() {
        for j in 0..grid[0].len() {
            if grid[i][j] == 2 {
                queue.push_back((i, j));
            } else if grid[i][j] == 1 {
                fresh_count += 1;
            }
        }
    }

    let mut minutes = 0;
    while !queue.is_empty() && fresh_count > 0 {
        for _ in 0..queue.len() {
            let (x, y) = queue.pop_front().unwrap();
            for (dx, dy) in &directions {
                let nx = x as isize + dx;
                let ny = y as isize + dy;
                if nx >= 0 && nx < grid.len() as isize && ny >= 0 && ny < grid[0].len() as isize {
                    if grid[nx as usize][ny as usize] == 1 {
                        grid[nx as usize][ny as usize] = 2;
                        fresh_count -= 1;
                        queue.push_back((nx as usize, ny as usize));
                    }
                }
            }
        }
        minutes += 1;
    }

    if fresh_count > 0 {
        -1
    } else {
        minutes
    }
}