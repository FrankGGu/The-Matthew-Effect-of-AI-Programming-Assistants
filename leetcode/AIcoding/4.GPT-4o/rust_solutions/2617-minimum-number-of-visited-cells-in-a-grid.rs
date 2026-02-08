use std::collections::VecDeque;

pub fn min_cells(grid: Vec<Vec<i32>>) -> i32 {
    let (m, n) = (grid.len(), grid[0].len());
    let mut visited = vec![vec![false; n]; m];
    let mut queue = VecDeque::new();

    queue.push_back((0, 0));
    visited[0][0] = true;
    let mut count = 1;

    while let Some((x, y)) = queue.pop_front() {
        let limit = grid[x][y];
        for i in (x + 1)..m {
            if grid[i][y] >= limit && !visited[i][y] {
                visited[i][y] = true;
                queue.push_back((i, y));
            }
        }
        for j in (y + 1)..n {
            if grid[x][j] >= limit && !visited[x][j] {
                visited[x][j] = true;
                queue.push_back((x, j));
            }
        }
        if (x, y) != (m - 1, n - 1) {
            count += 1;
        }
    }

    if visited[m - 1][n - 1] {
        count
    } else {
        -1
    }
}