pub fn fortress_count(fortress: Vec<Vec<char>>) -> i32 {
    let m = fortress.len();
    let n = fortress[0].len();
    let mut visited = vec![vec![false; n]; m];

    fn dfs(x: usize, y: usize, fortress: &Vec<Vec<char>>, visited: &mut Vec<Vec<bool>>) {
        if x >= fortress.len() || y >= fortress[0].len() || visited[x][y] || fortress[x][y] == '0' {
            return;
        }
        visited[x][y] = true;
        dfs(x.wrapping_sub(1), y, fortress, visited);
        dfs(x + 1, y, fortress, visited);
        dfs(x, y.wrapping_sub(1), fortress, visited);
        dfs(x, y + 1, fortress, visited);
    }

    let mut count = 0;
    for i in 0..m {
        for j in 0..n {
            if fortress[i][j] == '1' && !visited[i][j] {
                dfs(i, j, &fortress, &mut visited);
                count += 1;
            }
        }
    }
    count
}