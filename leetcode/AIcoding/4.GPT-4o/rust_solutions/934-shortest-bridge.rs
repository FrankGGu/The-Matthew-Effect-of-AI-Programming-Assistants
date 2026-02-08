use std::collections::VecDeque;

pub fn shortest_bridge(grid: Vec<Vec<i32>>) -> i32 {
    let (n, m) = (grid.len(), grid[0].len());
    let mut queue = VecDeque::new();
    let mut visited = vec![vec![false; m]; n];

    fn dfs(grid: &mut Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize, queue: &mut VecDeque<(usize, usize)>) {
        if i >= grid.len() || j >= grid[0].len() || visited[i][j] || grid[i][j] == 0 {
            return;
        }
        visited[i][j] = true;
        queue.push_back((i, j));
        dfs(grid, visited, i + 1, j, queue);
        dfs(grid, visited, i - 1, j, queue);
        dfs(grid, visited, i, j + 1, queue);
        dfs(grid, visited, i, j - 1, queue);
    }

    for i in 0..n {
        for j in 0..m {
            if grid[i][j] == 1 {
                dfs(&mut grid.clone(), &mut visited, i, j, &mut queue);
                break;
            }
        }
        if !queue.is_empty() {
            break;
        }
    }

    let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
    let mut steps = 0;

    while !queue.is_empty() {
        let size = queue.len();
        for _ in 0..size {
            let (x, y) = queue.pop_front().unwrap();
            for &(dx, dy) in &directions {
                let nx = (x as isize + dx) as usize;
                let ny = (y as isize + dy) as usize;
                if nx < n && ny < m {
                    if grid[nx][ny] == 1 && !visited[nx][ny] {
                        return steps;
                    }
                    if grid[nx][ny] == 0 && !visited[nx][ny] {
                        visited[nx][ny] = true;
                        queue.push_back((nx, ny));
                    }
                }
            }
        }
        steps += 1;
    }

    -1
}