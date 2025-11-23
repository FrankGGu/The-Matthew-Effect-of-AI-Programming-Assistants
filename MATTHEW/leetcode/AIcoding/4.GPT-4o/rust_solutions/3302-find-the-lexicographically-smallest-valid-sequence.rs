pub fn find_lex_smallest_sequence(n: i32, k: i32) -> String {
    let mut result = Vec::new();
    let mut visited = vec![false; n as usize + 1];
    let mut dfs = |pos: i32| {
        if pos == k {
            return true;
        }
        for i in 1..=n {
            if !visited[i as usize] {
                visited[i as usize] = true;
                result.push(i);
                if dfs(pos + 1) {
                    return true;
                }
                visited[i as usize] = false;
                result.pop();
            }
        }
        false
    };
    dfs(0);
    result.iter().map(|x| x.to_string()).collect::<Vec<_>>().join("")
}