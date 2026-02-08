impl Solution {
    pub fn crack_safe(n: i32, k: i32) -> String {
        if n == 1 && k == 1 {
            return "0".to_string();
        }

        let mut ans = String::new();
        let mut visited = std::collections::HashSet::new();
        let start = "0".repeat((n - 1) as usize);

        fn dfs(node: String, n: i32, k: i32, ans: &mut String, visited: &mut std::collections::HashSet<String>) {
            for i in 0..k {
                let next_node = node.clone() + &i.to_string();
                if !visited.contains(&next_node) {
                    visited.insert(next_node.clone());
                    dfs(next_node[1..].to_string(), n, k, ans, visited);
                    ans.push_str(&i.to_string());
                }
            }
        }

        dfs(start, n, k, &mut ans, &mut visited);
        ans.push_str(&"0".repeat((n - 1) as usize));
        ans
    }
}