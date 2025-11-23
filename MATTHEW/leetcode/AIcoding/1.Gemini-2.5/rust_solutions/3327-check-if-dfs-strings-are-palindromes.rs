struct Solution;

impl Solution {
    pub fn check_dfs_strings_are_palindromes(adj: Vec<Vec<usize>>, chars: Vec<char>) -> bool {
        if chars.is_empty() {
            return true;
        }

        let mut path_chars: Vec<char> = Vec::new();
        Self::dfs_helper(&adj, &chars, 0, &mut path_chars)
    }

    fn dfs_helper(
        adj: &Vec<Vec<usize>>,
        chars: &Vec<char>,
        node_idx: usize,
        current_path: &mut Vec<char>,
    ) -> bool {
        current_path.push(chars[node_idx]);

        if adj[node_idx].is_empty() {
            let is_pal = Self::is_palindrome(current_path);
            current_path.pop();
            return is_pal;
        }

        for &next_node_idx in &adj[node_idx] {
            if !Self::dfs_helper(adj, chars, next_node_idx, current_path) {
                current_path.pop();
                return false;
            }
        }

        current_path.pop();
        true
    }

    fn is_palindrome(s_chars: &[char]) -> bool {
        let n = s_chars.len();
        for i in 0..n / 2 {
            if s_chars[i] != s_chars[n - 1 - i] {
                return false;
            }
        }
        true
    }
}