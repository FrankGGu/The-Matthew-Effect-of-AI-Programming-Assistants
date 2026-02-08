struct Solution;

impl Solution {
    pub fn longest_path(parent: Vec<i32>, s: String) -> i32 {
        let n = parent.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        // Build adjacency list. Node 0 is always the root.
        // parent[i] is the parent of node i, for i > 0.
        for i in 1..n {
            adj[parent[i] as usize].push(i);
        }

        let s_chars: Vec<char> = s.chars().collect();
        let mut max_path_len = 1; // Minimum path length is 1 (a single node)

        // Start DFS from the root (node 0).
        Self::dfs(0, &adj, &s_chars, &mut max_path_len);

        max_path_len
    }

    // This DFS function returns the longest path length starting at node 'u'
    // and going downwards, where all adjacent characters on the path are different.
    // This path includes node 'u' itself.
    fn dfs(u: usize, adj: &Vec<Vec<usize>>, s_chars: &Vec<char>, max_path_len: &mut i32) -> i32 {
        let mut longest_branch_from_u = 0; // Length of the longest valid path segment extending downwards from a child of u (excluding u itself)
        let mut second_longest_branch_from_u = 0; // Length of the second longest valid path segment extending downwards from a child of u (excluding u itself)

        // Iterate over children of 'u'
        for &v in &adj[u] {
            // Recursively call DFS for child 'v'
            let child_branch_len = Self::dfs(v, adj, s_chars, max_path_len);

            // If characters of 'u' and 'v' are different, this branch is valid
            if s_chars[u] != s_chars[v] {
                if child_branch_len > longest_branch_from_u {
                    second_longest_branch_from_u = longest_branch_from_u;
                    longest_branch_from_u = child_branch_len;
                } else if child_branch_len > second_longest_branch_from_u {
                    second_longest_branch_from_u = child_branch_len;
                }
            }
        }

        // Update the global maximum path length.
        // A path passing through 'u' could be formed by combining its two longest valid downward branches.
        // The +1 accounts for node 'u' itself.
        *max_path_len = (*max_path_len).max(longest_branch_from_u + second_longest_branch_from_u + 1);

        // Return the length of the longest valid path starting at 'u' and going downwards.
        // This path is used by 'u's parent to extend its own path.
        // The +1 accounts for node 'u' itself.
        longest_branch_from_u + 1
    }
}