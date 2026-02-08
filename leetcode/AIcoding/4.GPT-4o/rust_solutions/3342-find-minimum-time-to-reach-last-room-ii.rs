use std::collections::VecDeque;

pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
    let n = grid.len();
    let m = grid[0].len();
    let mut dist = vec![vec![i32::MAX; m]; n];
    let mut queue = VecDeque::new();

    dist[0][0] = 0;
    queue.push_back((0, 0));

    while let Some((x, y)) = queue.pop_front() {
        let curr_time = dist[x][y];

        for (dx, dy) in &directions {
            let nx = x as isize + *dx;
            let ny = y as isize + *dy;

            if nx >= 0 && nx < n as isize && ny >= 0 && ny < m as isize {
                let next_time = curr_time + 1 + grid[nx as usize][ny as usize];

                if next_time < dist[nx as usize][ny as usize] {
                    dist[nx as usize][ny as usize] = next_time;
                    if grid[nx as usize][ny as usize] == 0 {
                        queue.push_front((nx as usize, ny as usize));
                    } else {
                        queue.push_back((nx as usize, ny as usize));
                    }
                }
            }
        }
    }

    if dist[n - 1][m - 1] == i32::MAX {
        -1
    } else {
        dist[n - 1][m - 1]
    }
}