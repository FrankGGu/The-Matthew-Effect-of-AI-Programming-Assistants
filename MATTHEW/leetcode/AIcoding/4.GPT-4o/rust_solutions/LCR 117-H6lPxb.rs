pub fn num_similar_groups(strs: Vec<String>) -> i32 {
    fn are_similar(s1: &str, s2: &str) -> bool {
        let mut diff = vec![];
        for (c1, c2) in s1.chars().zip(s2.chars()) {
            if c1 != c2 {
                diff.push((c1, c2));
            }
        }
        (diff.len() == 2 && diff[0] == (diff[1].1, diff[1].0)) || diff.is_empty()
    }

    fn dfs(node: usize, visited: &mut Vec<bool>, strs: &[String]) {
        visited[node] = true;
        for i in 0..strs.len() {
            if !visited[i] && are_similar(&strs[node], &strs[i]) {
                dfs(i, visited, strs);
            }
        }
    }

    let n = strs.len();
    let mut visited = vec![false; n];
    let mut groups = 0;

    for i in 0..n {
        if !visited[i] {
            dfs(i, &mut visited, &strs);
            groups += 1;
        }
    }

    groups
}