use std::collections::HashSet;

impl Solution {
    pub fn can_escape(maze: Vec<Vec<i32>>, start: Vec<i32>, destination: Vec<i32>) -> bool {
        let m = maze.len();
        let n = maze[0].len();
        let mut visited = HashSet::new();
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];
        let start = (start[0], start[1]);
        let destination = (destination[0], destination[1]);

        fn dfs(maze: &Vec<Vec<i32>>, position: (i32, i32), destination: (i32, i32), visited: &mut HashSet<(i32, i32)>) -> bool {
            if position == destination {
                return true;
            }
            if visited.contains(&position) {
                return false;
            }
            visited.insert(position);
            let (x, y) = position;
            for (dx, dy) in &directions {
                let mut new_x = x;
                let mut new_y = y;
                while new_x + dx >= 0 && new_x + dx < maze.len() as i32 && new_y + dy >= 0 && new_y + dy < maze[0].len() as i32 && maze[(new_x + dx) as usize][(new_y + dy) as usize] == 0 {
                    new_x += dx;
                    new_y += dy;
                }
                if dfs(maze, (new_x, new_y), destination, visited) {
                    return true;
                }
            }
            false
        }

        dfs(&maze, start, destination, &mut visited)
    }
}