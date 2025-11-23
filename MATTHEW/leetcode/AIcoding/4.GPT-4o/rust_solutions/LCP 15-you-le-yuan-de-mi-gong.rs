pub fn can_reach_exit(maze: Vec<Vec<char>>, start: Vec<i32>, end: Vec<i32>) -> bool {
    let rows = maze.len();
    let cols = maze[0].len();
    let mut visited = vec![vec![false; cols]; rows];
    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

    fn dfs(maze: &Vec<Vec<char>>, x: usize, y: usize, visited: &mut Vec<Vec<bool>>, directions: &Vec<(i32, i32)>) -> bool {
        if maze[x][y] == 'E' {
            return true;
        }
        visited[x][y] = true;

        for (dx, dy) in directions.iter() {
            let mut nx = x as i32 + dx;
            let mut ny = y as i32 + dy;

            while nx >= 0 && nx < maze.len() as i32 && ny >= 0 && ny < maze[0].len() as i32 && maze[nx as usize][ny as usize] != '#' {
                if visited[nx as usize][ny as usize] {
                    break;
                }
                if maze[nx as usize][ny as usize] == 'E' {
                    return true;
                }
                visited[nx as usize][ny as usize] = true;
                nx += dx;
                ny += dy;
            }
        }
        false
    }

    let start_x = start[0] as usize;
    let start_y = start[1] as usize;
    let end_x = end[0] as usize;
    let end_y = end[1] as usize;

    if maze[end_x][end_y] == '#' || maze[start_x][start_y] == '#' {
        return false;
    }

    dfs(&maze, start_x, start_y, &mut visited, &directions)
}