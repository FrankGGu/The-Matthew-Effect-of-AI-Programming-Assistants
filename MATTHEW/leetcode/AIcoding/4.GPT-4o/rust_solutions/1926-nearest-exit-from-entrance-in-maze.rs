use std::collections::VecDeque;

pub fn nearest_exit(maze: Vec<Vec<char>>, entrance: Vec<i32>) -> i32 {
    let rows = maze.len();
    let cols = maze[0].len();
    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
    let mut queue = VecDeque::new();
    let mut visited = vec![vec![false; cols]; rows];

    let start_x = entrance[0];
    let start_y = entrance[1];
    queue.push_back((start_x, start_y, 0));
    visited[start_x as usize][start_y as usize] = true;

    while let Some((x, y, distance)) = queue.pop_front() {
        if (x != start_x || y != start_y) && (x == 0 || x == (rows - 1) as i32 || y == 0 || y == (cols - 1) as i32) {
            return distance;
        }

        for (dx, dy) in &directions {
            let new_x = x + dx;
            let new_y = y + dy;
            if new_x >= 0 && new_x < rows as i32 && new_y >= 0 && new_y < cols as i32 
               && maze[new_x as usize][new_y as usize] == '.' && !visited[new_x as usize][new_y as usize] {
                visited[new_x as usize][new_y as usize] = true;
                queue.push_back((new_x, new_y, distance + 1));
            }
        }
    }

    -1
}