pub fn treasure_island(land: Vec<Vec<char>>) -> i32 {
    let mut visited = vec![vec![false; land[0].len()]; land.len()];
    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
    let mut queue = std::collections::VecDeque::new();
    queue.push_back((0, 0, 0));
    visited[0][0] = true;

    while let Some((x, y, steps)) = queue.pop_front() {
        if land[x][y] == 'X' {
            return steps;
        }

        for (dx, dy) in &directions {
            let nx = x as isize + dx;
            let ny = y as isize + dy;

            if nx >= 0 && nx < land.len() as isize && ny >= 0 && ny < land[0].len() as isize {
                let nx = nx as usize;
                let ny = ny as usize;
                if land[nx][ny] != 'D' && !visited[nx][ny] {
                    visited[nx][ny] = true;
                    queue.push_back((nx, ny, steps + 1));
                }
            }
        }
    }

    -1
}