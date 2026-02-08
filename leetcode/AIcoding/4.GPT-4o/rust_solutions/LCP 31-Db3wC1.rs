use std::collections::VecDeque;

pub fn can_reach_destination(maze: Vec<Vec<i32>>, start: Vec<i32>, destination: Vec<i32>) -> bool {
    let (rows, cols) = (maze.len(), maze[0].len());
    let (start_x, start_y) = (start[0], start[1]);
    let (dest_x, dest_y) = (destination[0], destination[1]);

    if maze[start_x as usize][start_y as usize] == 1 || maze[dest_x as usize][dest_y as usize] == 1 {
        return false;
    }

    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
    let mut visited = vec![vec![false; cols]; rows];
    let mut queue = VecDeque::new();

    queue.push_back((start_x, start_y));
    visited[start_x as usize][start_y as usize] = true;

    while let Some((x, y)) = queue.pop_front() {
        if x == dest_x && y == dest_y {
            return true;
        }

        for (dx, dy) in &directions {
            let mut nx = x;
            let mut ny = y;

            while nx + dx >= 0 && nx + dx < rows as i32 && ny + dy >= 0 && ny + dy < cols as i32 && maze[(nx + dx) as usize][(ny + dy) as usize] == 0 {
                nx += dx;
                ny += dy;
            }

            if !visited[nx as usize][ny as usize] {
                visited[nx as usize][ny as usize] = true;
                queue.push_back((nx, ny));
            }
        }
    }
    false
}