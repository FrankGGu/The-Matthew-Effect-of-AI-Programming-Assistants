pub fn latest_day_to_cross(arr: Vec<i32>, m: i32, n: i32) -> i32 {
    let mut left = 1;
    let mut right = arr.len() as i32;
    let mut result = 0;

    while left <= right {
        let mid = left + (right - left) / 2;
        if can_cross(&arr, mid, m, n) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    result
}

fn can_cross(arr: &[i32], day: i32, m: i32, n: i32) -> bool {
    let mut grid = vec![vec![0; n as usize]; m as usize];
    let mut visited = vec![vec![false; n as usize]; m as usize];
    for &x in arr.iter().take(day as usize) {
        let (r, c) = ((x - 1) / n + 1, (x - 1) % n + 1);
        grid[(r - 1) as usize][(c - 1) as usize] = 1;
    }

    let mut queue = std::collections::VecDeque::new();
    for j in 0..n {
        if grid[0][j as usize] == 0 {
            queue.push_back((0, j));
            visited[0][j as usize] = true;
        }
    }

    while let Some((x, y)) = queue.pop_front() {
        if x == m - 1 {
            return true;
        }
        for &(dx, dy) in &[(1, 0), (-1, 0), (0, 1), (0, -1)] {
            let nx = x as i32 + dx;
            let ny = y as i32 + dy;
            if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx as usize][ny as usize] && grid[nx as usize][ny as usize] == 0 {
                visited[nx as usize][ny as usize] = true;
                queue.push_back((nx, ny));
            }
        }
    }

    false
}