impl Solution {
    pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len() as i32;
        let n = grid[0].len() as i32;

        if grid[0][1] > 1 && grid[1][0] > 1 {
            if grid[0][1] > grid[1][0] {
                return grid[0][1] + grid[1][0] + m + n - 4;
            } else {
                return grid[1][0] + grid[0][1] + m + n - 4;
            }
        }

        let mut dist = vec![vec![i32::MAX; n as usize]; m as usize];
        dist[0][0] = 0;

        use std::collections::BinaryHeap;
        use std::cmp::Reverse;

        let mut pq = BinaryHeap::new();
        pq.push(Reverse((0, 0, 0)));

        let dx = [0, 0, 1, -1];
        let dy = [1, -1, 0, 0];

        while let Some(Reverse((d, x, y))) = pq.pop() {
            if d > dist[x as usize][y as usize] {
                continue;
            }

            for i in 0..4 {
                let nx = x + dx[i];
                let ny = y + dy[i];

                if nx >= 0 && nx < m && ny >= 0 && ny < n {
                    let wait_time = if grid[nx as usize][ny as usize] <= d {
                        0
                    } else {
                        grid[nx as usize][ny as usize] - d + 1
                    };

                    let new_dist = d + wait_time + 1;

                    if new_dist < dist[nx as usize][ny as usize] {
                        dist[nx as usize][ny as usize] = new_dist;
                        pq.push(Reverse((new_dist, nx, ny)));
                    }
                }
            }
        }

        if dist[(m - 1) as usize][(n - 1) as usize] == i32::MAX {
            return -1;
        }

        std::cmp::max(dist[(m - 1) as usize][(n - 1) as usize], grid[(m - 1) as usize][(n - 1) as usize])
    }
}