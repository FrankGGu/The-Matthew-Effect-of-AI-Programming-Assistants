use std::collections::BinaryHeap;

pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
    let m = grid.len();
    let n = grid[0].len();
    let mut dist = vec![vec![i32::MAX; n]; m];
    dist[0][0] = 0;

    let mut heap = BinaryHeap::new();
    heap.push((0, 0, 0)); // (time, row, col)

    while let Some((time, x, y)) = heap.pop() {
        let time = -time;

        if x == m - 1 && y == n - 1 {
            return time;
        }

        for (dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
            let nx = x as isize + dx;
            let ny = y as isize + dy;
            if nx >= 0 && nx < m as isize && ny >= 0 && ny < n as isize {
                let new_time = time + 1;
                let wait_time = (grid[nx as usize][ny as usize] - new_time % grid[nx as usize][ny as usize]) % grid[nx as usize][ny as usize];
                let arrival_time = new_time + wait_time;

                if arrival_time < dist[nx as usize][ny as usize] {
                    dist[nx as usize][ny as usize] = arrival_time;
                    heap.push((-arrival_time, nx as usize, ny as usize));
                }
            }
        }
    }

    -1
}