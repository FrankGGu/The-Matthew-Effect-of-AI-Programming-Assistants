pub fn crack_safe(n: i32, k: i32) -> String {
    let total_nodes = k.pow(n as u32);
    let mut result = String::new();
    let mut visited = vec![false; total_nodes as usize];
    let mut path = String::new();

    fn dfs(n: i32, k: i32, visited: &mut Vec<bool>, path: &mut String, result: &mut String) {
        if path.len() == k.pow(n as u32) as usize + n as usize {
            *result = path.clone();
            return;
        }
        for i in 0..k {
            let next = path.chars().skip(path.len() - n as usize + 1).collect::<String>() + &i.to_string();
            let next_index = next.chars().collect::<String>().parse::<usize>().unwrap();
            if !visited[next_index] {
                visited[next_index] = true;
                path.push_str(&i.to_string());
                dfs(n, k, visited, path, result);
                visited[next_index] = false;
                path.pop();
            }
        }
    }

    path.push_str(&"0".repeat(n as usize));
    dfs(n, k, &mut visited, &mut path, &mut result);
    result
}