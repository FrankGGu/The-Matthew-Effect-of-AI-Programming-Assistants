use std::collections::VecDeque;

impl Solution {
    pub fn nearest_exit(maze: Vec<Vec<char>>, entrance: Vec<i32>) -> i32 {
        let rows = maze.len() as i32;
        let cols = maze[0].len() as i32;
        let directions = vec![(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut queue = VecDeque::new();
        queue.push_back((entrance[0], entrance[1], 0));
        let mut visited = vec![vec![false; cols as usize]; rows as usize];
        visited[entrance[0] as usize][entrance[1] as usize] = true;

        while let Some((x, y, steps)) = queue.pop_front() {
            if (x != entrance[0] || y != entrance[1]) && (x == 0 || x == rows - 1 || y == 0 || y == cols - 1) {
                return steps;
            }

            for (dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && nx < rows && ny >= 0 && ny < cols && maze[nx as usize][ny as usize] == '.' && !visited[nx as usize][ny as usize] {
                    visited[nx as usize][ny as usize] = true;
                    queue.push_back((nx, ny, steps + 1));
                }
            }
        }

        -1
    }
}