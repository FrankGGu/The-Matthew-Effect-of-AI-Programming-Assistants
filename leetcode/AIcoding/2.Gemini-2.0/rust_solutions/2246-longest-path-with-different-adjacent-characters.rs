use std::cmp::max;

impl Solution {
    pub fn longest_path(parent: Vec<i32>, s: String) -> i32 {
        let n = parent.len();
        let s: Vec<char> = s.chars().collect();
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        for i in 1..n {
            adj[parent[i] as usize].push(i);
        }

        let mut ans = 0;

        fn dfs(node: usize, adj: &Vec<Vec<usize>>, s: &Vec<char>, ans: &mut i32) -> i32 {
            let mut max1 = 0;
            let mut max2 = 0;

            for &child in &adj[node] {
                let len = dfs(child, adj, s, ans);
                if s[node] != s[child] {
                    if len > max1 {
                        max2 = max1;
                        max1 = len;
                    } else if len > max2 {
                        max2 = len;
                    }
                }
            }

            *ans = max(*ans, max1 + max2 + 1);
            max1 + 1
        }

        dfs(0, &adj, &s, &mut ans);
        ans
    }
}