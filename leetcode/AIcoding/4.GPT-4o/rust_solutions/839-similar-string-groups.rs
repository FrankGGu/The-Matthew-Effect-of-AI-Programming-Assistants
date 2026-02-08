pub fn num_similar_groups(strs: Vec<String>) -> i32 {
    fn is_similar(s1: &str, s2: &str) -> bool {
        let mut diff = 0;
        let mut chars1 = Vec::new();
        let mut chars2 = Vec::new();
        for (c1, c2) in s1.chars().zip(s2.chars()) {
            if c1 != c2 {
                diff += 1;
                chars1.push(c1);
                chars2.push(c2);
            }
        }
        (diff == 2 && chars1[0] == chars2[1] && chars1[1] == chars2[0]) || diff == 0
    }

    fn dfs(index: usize, visited: &mut Vec<bool>, strs: &Vec<String>) {
        visited[index] = true;
        for i in 0..strs.len() {
            if !visited[i] && is_similar(&strs[index], &strs[i]) {
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