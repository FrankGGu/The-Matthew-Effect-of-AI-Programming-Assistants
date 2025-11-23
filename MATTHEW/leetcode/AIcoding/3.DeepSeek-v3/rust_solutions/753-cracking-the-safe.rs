impl Solution {
    pub fn crack_safe(n: i32, k: i32) -> String {
        let n = n as usize;
        let k = k as usize;
        let total = k.pow(n as u32);
        let mut visited = std::collections::HashSet::new();
        let mut res = String::new();

        for _ in 0..n {
            res.push('0');
        }
        visited.insert(res.clone());

        Self::dfs(&mut res, total, n, k, &mut visited);

        res
    }

    fn dfs(res: &mut String, total: usize, n: usize, k: usize, visited: &mut std::collections::HashSet<String>) -> bool {
        if visited.len() == total {
            return true;
        }

        let last = res.len() - n + 1;
        let prefix = &res[last..].to_string();

        for i in 0..k {
            let next = format!("{}{}", prefix, i);
            if !visited.contains(&next) {
                visited.insert(next.clone());
                res.push_str(&i.to_string());
                if Self::dfs(res, total, n, k, visited) {
                    return true;
                }
                res.pop();
                visited.remove(&next);
            }
        }

        false
    }
}