impl Solution {
    pub fn crack_safe(n: i32, k: i32) -> String {
        if n == 1 && k == 1 {
            return "0".to_string();
        }

        let total_len = (k as i64).pow(n as u32) as usize;
        let mut visited = std::collections::HashSet::new();
        let mut result = String::new();
        let start = "0".repeat((n - 1) as usize);

        fn dfs(node: String, k: i32, visited: &mut std::collections::HashSet<String>, result: &mut String, n: i32, total_len: usize) {
            for i in 0..k {
                let next_node = node.clone() + &i.to_string();
                if !visited.contains(&next_node) {
                    visited.insert(next_node.clone());
                    let next_prefix = next_node[(1 as usize)..].to_string();
                    dfs(next_prefix, k, visited, result, n, total_len);
                    result.push_str(&i.to_string());
                }
            }
        }

        dfs(start, k, &mut visited, &mut result, n, total_len);
        result.push_str(&"0".repeat((n - 1) as usize));
        result
    }
}