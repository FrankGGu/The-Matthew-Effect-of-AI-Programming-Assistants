impl Solution {
    pub fn are_dfs_strings_palindromes(n: i32, edges: Vec<Vec<i32>>, s: String) -> Vec<bool> {
        let n = n as usize;
        let s: Vec<char> = s.chars().collect();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize - 1;
            let v = edge[1] as usize - 1;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans: Vec<bool> = vec![false; n];
        let mut visited: Vec<bool> = vec![false; n];

        for i in 0..n {
            if !visited[i] {
                let mut path: Vec<usize> = vec![];
                let mut current_ans: Vec<bool> = vec![false; n];
                Self::dfs(i, &adj, &s, &mut visited, &mut path, &mut current_ans);

                for j in 0..n {
                    ans[j] = ans[j] || current_ans[j];
                }
            }
        }

        ans
    }

    fn dfs(
        u: usize,
        adj: &Vec<Vec<usize>>,
        s: &Vec<char>,
        visited: &mut Vec<bool>,
        path: &mut Vec<usize>,
        current_ans: &mut Vec<bool>,
    ) {
        visited[u] = true;
        path.push(u);

        if Self::is_palindrome(path, s) {
            for &node in path.iter() {
                current_ans[node] = true;
            }
        }

        for &v in &adj[u] {
            if !visited[v] {
                Self::dfs(v, adj, s, visited, path, current_ans);
            }
        }

        path.pop();
    }

    fn is_palindrome(path: &Vec<usize>, s: &Vec<char>) -> bool {
        let mut left = 0;
        let mut right = path.len() - 1;

        while left < right {
            if s[path[left]] != s[path[right]] {
                return false;
            }
            left += 1;
            right -= 1;
        }

        true
    }
}