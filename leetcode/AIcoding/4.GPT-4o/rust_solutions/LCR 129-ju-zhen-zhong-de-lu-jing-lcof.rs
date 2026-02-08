impl Solution {
    pub fn has_path(maze: Vec<Vec<char>>, start: Vec<i32>, destination: Vec<i32>) -> bool {
        let (m, n) = (maze.len(), maze[0].len());
        let (start_x, start_y) = (start[0] as usize, start[1] as usize);
        let (dest_x, dest_y) = (destination[0] as usize, destination[1] as usize);

        let mut visited = vec![vec![false; n]; m];
        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

        fn dfs(maze: &Vec<Vec<char>>, visited: &mut Vec<Vec<bool>>, x: usize, y: usize, dest_x: usize, dest_y: usize, directions: &Vec<(i32, i32)>) -> bool {
            if x == dest_x && y == dest_y {
                return true;
            }
            visited[x][y] = true;

            for (dx, dy) in directions {
                let (mut nx, mut ny) = (x as i32, y as i32);
                while nx + dx >= 0 && nx + dx < maze.len() as i32 && ny + dy >= 0 && ny + dy < maze[0].len() as i32 && maze[nx as usize][ny as usize] == '.' {
                    nx += dx;
                    ny += dy;
                }
                if !visited[nx as usize][ny as usize] && dfs(maze, visited, nx as usize, ny as usize, dest_x, dest_y, directions) {
                    return true;
                }
            }
            false
        }

        dfs(&maze, &mut visited, start_x, start_y, dest_x, dest_y, &directions)
    }
}