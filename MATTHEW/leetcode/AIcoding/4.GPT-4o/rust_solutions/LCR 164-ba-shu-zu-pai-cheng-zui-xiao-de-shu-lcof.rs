impl Solution {
    pub fn crack_safe(n: i32, k: i32) -> String {
        let mut visited = vec![false; (k.pow(n as u32) as usize)];
        let mut result = String::new();
        let total_nodes = k.pow(n as u32);

        fn dfs(node: usize, n: usize, k: usize, visited: &mut Vec<bool>, result: &mut String) {
            for i in 0..k {
                let next_node = (node * k + i) as usize;
                if !visited[next_node] {
                    visited[next_node] = true;
                    dfs(next_node, n, k, visited, result);
                    result.push_str(&i.to_string());
                }
            }
        }

        for i in 0..k {
            visited[i as usize] = true;
            result.push_str(&i.to_string());
            dfs(i as usize, n as usize, k as usize, &mut visited, &mut result);
        }

        result
    }
}