pub fn contain_virus(is_infected: Vec<Vec<i32>>) -> i32 {
    let mut total_cost = 0;
    let mut visited = vec![vec![false; is_infected[0].len()]; is_infected.len()];

    while let Some((cost, area)) = find_most_threatening_area(&is_infected, &mut visited) {
        total_cost += cost;
        for (x, y) in area {
            is_infected[x][y] = 1;
        }
        for i in 0..is_infected.len() {
            for j in 0..is_infected[0].len() {
                if is_infected[i][j] == 1 && !visited[i][j] {
                    visited[i][j] = true;
                }
            }
        }
    }

    total_cost
}

fn find_most_threatening_area(is_infected: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>) -> Option<(i32, Vec<(usize, usize)>)> {
    let mut max_cost = 0;
    let mut best_area = Vec::new();

    for i in 0..is_infected.len() {
        for j in 0..is_infected[0].len() {
            if is_infected[i][j] == 1 && !visited[i][j] {
                let (cost, area) = bfs(is_infected, i, j, visited);
                if cost > max_cost {
                    max_cost = cost;
                    best_area = area;
                }
            }
        }
    }

    if max_cost > 0 {
        Some((max_cost, best_area))
    } else {
        None
    }
}

fn bfs(is_infected: &Vec<Vec<i32>>, start_x: usize, start_y: usize, visited: &mut Vec<Vec<bool>>) -> (i32, Vec<(usize, usize)>) {
    let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];
    let mut queue = vec![(start_x, start_y)];
    let mut area = Vec::new();
    let mut cost = 0;

    while let Some((x, y)) = queue.pop() {
        area.push((x, y));
        visited[x][y] = true;

        for (dx, dy) in &directions {
            let (nx, ny) = (x as isize + dx, y as isize + dy);
            if nx >= 0 && nx < is_infected.len() as isize && ny >= 0 && ny < is_infected[0].len() as isize {
                let (nx, ny) = (nx as usize, ny as usize);
                if is_infected[nx][ny] == 0 && !visited[nx][ny] {
                    cost += 1;
                    visited[nx][ny] = true;
                } else if is_infected[nx][ny] == 1 && !visited[nx][ny] {
                    queue.push((nx, ny));
                }
            }
        }
    }

    (cost, area)
}