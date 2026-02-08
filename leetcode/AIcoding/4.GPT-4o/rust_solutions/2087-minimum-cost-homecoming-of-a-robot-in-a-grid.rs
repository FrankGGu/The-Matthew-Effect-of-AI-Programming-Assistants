use std::collections::BinaryHeap;

pub fn min_cost(home: Vec<i32>, row: i32, col: i32, grid: Vec<Vec<i32>>) -> i32 {
    let rows = grid.len();
    let cols = grid[0].len();
    let mut dist = vec![vec![i32::MAX; cols]; rows];
    let mut heap = BinaryHeap::new();

    dist[home[0] as usize][home[1] as usize] = 0;
    heap.push((0, home[0] as usize, home[1] as usize));

    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

    while let Some((cost, r, c)) = heap.pop() {
        if r == row as usize && c == col as usize {
            return -cost;
        }

        let cost = -cost;

        for (dr, dc) in &directions {
            let nr = r as isize + dr;
            let nc = c as isize + dc;
            if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                let new_cost = cost + grid[nr as usize][nc as usize];
                if new_cost < dist[nr as usize][nc as usize] {
                    dist[nr as usize][nc as usize] = new_cost;
                    heap.push((-new_cost, nr as usize, nc as usize));
                }
            }
        }
    }

    -1
}