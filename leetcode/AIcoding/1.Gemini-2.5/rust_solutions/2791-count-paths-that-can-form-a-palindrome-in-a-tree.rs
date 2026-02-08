use std::collections::HashMap;
use std::cell::RefCell;

struct Solution;

impl Solution {
    pub fn count_palindrome_paths(parent: Vec<i32>, s: String) -> i64 {
        let n = parent.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let s_chars: Vec<char> = s.chars().collect();

        let mut root = 0;
        for i in 0..n {
            if parent[i] == -1 {
                root = i;
            } else {
                adj[parent[i] as usize].push(i);
                adj[i].push(parent[i] as usize);
            }
        }

        let total_paths = RefCell::new(0i64);
        let path_mask_counts: RefCell<HashMap<u32, i64>> = RefCell::new(HashMap::new());

        // Initialize with mask 0 for an imaginary node before the root.
        // This accounts for paths starting at the root itself (e.g., root-root, or root-child).
        path_mask_counts.borrow_mut().insert(0, 1);

        Self::dfs(
            root,
            n, // Use n as a dummy parent value that won't match any valid node index
            0, // Initial mask from imaginary parent to root's parent
            &adj,
            &s_chars,
            &path_mask_counts,
            &total_paths,
        );

        *total_paths.borrow()
    }

    fn dfs(
        u: usize,
        p: usize,
        current_mask_from_root_parent: u32,
        adj: &Vec<Vec<usize>>,
        s_chars: &Vec<char>,
        path_mask_counts: &RefCell<HashMap<u32, i64>>,
        total_paths: &RefCell<i64>,
    ) {
        // Calculate the mask from the imaginary root_parent to the current node 'u'
        let node_char_bit = 1 << (s_chars[u] as u8 - b'a');
        let mask_to_u = current_mask_from_root_parent ^ node_char_bit;

        // Acquire mutable references for the shared state
        let mut counts_map = path_mask_counts.borrow_mut();
        let mut ans_val = total_paths.borrow_mut();

        // Count paths (v, u) such that path_mask_v ^ mask_to_u forms a palindrome.
        // path_mask_v is the mask from root_parent to node v.
        // The `counts_map` stores path_mask_v for all nodes 'v' visited so far in DFS order.

        // Case 1: path_mask_v ^ mask_to_u == 0 (i.e., path_mask_v == mask_to_u)
        // This means the path from v to u has a mask of 0, which is a palindrome.
        *ans_val += counts_map.get(&mask_to_u).unwrap_or(&0);

        // Case 2: path_mask_v ^ mask_to_u == (1 << i) for some i (i.e., path_mask_v == mask_to_u ^ (1 << i))
        // This means the path from v to u has a mask with exactly one bit set, which is a palindrome.
        for i in 0..26 {
            let target_mask = mask_to_u ^ (1 << i);
            *ans_val += counts_map.get(&target_mask).unwrap_or(&0);
        }

        // Add the current node's mask to the frequency map
        *counts_map.entry(mask_to_u).or_insert(0) += 1;

        // Recurse for children
        for &v in &adj[u] {
            if v != p {
                Self::dfs(v, u, mask_to_u, adj, s_chars, path_mask_counts, total_paths);
            }
        }

        // No backtracking (decrementing counts) is needed for this problem.
        // The `path_mask_counts` map accumulates masks from all previously visited nodes in DFS order.
        // Each undirected path (u,v) is counted exactly once when the node visited later in DFS order is processed.
    }
}