use std::collections::HashMap;

impl Solution {
    pub fn longest_path(parent: Vec<i32>, s: String) -> i32 {
        let n = parent.len();
        let s = s.chars().collect::<Vec<_>>();
        let mut children = vec![vec![]; n];
        for i in 1..n {
            children[parent[i] as usize].push(i);
        }
        let mut max_len = 1;
        Self::dfs(0, &children, &s, &mut max_len);
        max_len
    }

    fn dfs(node: usize, children: &Vec<Vec<usize>>, s: &Vec<char>, max_len: &mut i32) -> i32 {
        let mut longest = 0;
        let mut second_longest = 0;
        for &child in &children[node] {
            let child_len = Self::dfs(child, children, s, max_len);
            if s[child] != s[node] {
                if child_len > longest {
                    second_longest = longest;
                    longest = child_len;
                } else if child_len > second_longest {
                    second_longest = child_len;
                }
            }
        }
        *max_len = (*max_len).max(1 + longest + second_longest);
        1 + longest
    }
}