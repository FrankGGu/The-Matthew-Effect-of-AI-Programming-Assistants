pub fn find_circle_num(is_connected: Vec<Vec<i32>>) -> i32 {
    let n = is_connected.len();
    let mut visited = vec![false; n];
    let mut provinces = 0;

    fn dfs(is_connected: &Vec<Vec<i32>>, visited: &mut Vec<bool>, node: usize) {
        visited[node] = true;
        for neighbor in 0..is_connected.len() {
            if is_connected[node][neighbor] == 1 && !visited[neighbor] {
                dfs(is_connected, visited, neighbor);
            }
        }
    }

    for i in 0..n {
        if !visited[i] {
            dfs(&is_connected, &mut visited, i);
            provinces += 1;
        }
    }

    provinces
}