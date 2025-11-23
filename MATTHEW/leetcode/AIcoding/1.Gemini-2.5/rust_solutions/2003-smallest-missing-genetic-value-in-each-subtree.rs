use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn smallest_missing_value_subtree(parents: Vec<i32>, nums: Vec<i32>) -> Vec<i32> {
        let n = parents.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut one_idx: Option<usize> = None;

        // Build adjacency list and find the node with value 1
        for i in 0..n {
            if nums[i] == 1 {
                one_idx = Some(i);
            }
            if parents[i] != -1 {
                adj[parents[i] as usize].push(i);
            }
        }

        // Initialize all answers to 1. This is correct for subtrees not containing 1.
        let mut ans: Vec<i32> = vec![1; n];

        // If no node has a genetic value of 1, then 1 is missing in every subtree.
        if let Some(mut current_node) = one_idx {
            let mut current_set: HashSet<i32> = HashSet::new();
            let mut current_next_missing: i32 = 1;

            // `visited` array to ensure each node is processed only once by `dfs_collect_all`
            // or the main loop. This is crucial for overall O(N) complexity.
            let mut visited: Vec<bool> = vec![false; n];

            // Helper function to collect all genetic values in a subtree into `current_set`.
            // It marks nodes as visited to avoid redundant processing.
            fn dfs_collect_all(
                u: usize,
                adj: &Vec<Vec<usize>>,
                nums: &Vec<i32>,
                current_set: &mut HashSet<i32>,
                visited: &mut Vec<bool>,
            ) {
                if visited[u] {
                    return;
                }
                visited[u] = true;
                current_set.insert(nums[u]);
                for &v in adj[u].iter() {
                    dfs_collect_all(v, adj, nums, current_set, visited);
                }
            }

            let mut prev_node_on_path: Option<usize> = None;

            // Traverse upwards from `one_idx` to the root (node 0).
            loop {
                // Mark the current node as visited.
                // This prevents `dfs_collect_all` from processing it again.
                visited[current_node] = true;

                // Add the current node's genetic value to the set.
                current_set.insert(nums[current_node]);

                // For each child of the current node:
                // If the child is NOT the one that led us to `current_node` (i.e., not `prev_node_on_path`),
                // then recursively collect all genetic values from that child's subtree.
                // This ensures `current_set` contains all values in the subtree rooted at `current_node`.
                for &child in adj[current_node].iter() {
                    if Some(child) != prev_node_on_path {
                        dfs_collect_all(child, adj, nums, &mut current_set, &mut visited);
                    }
                }

                // After collecting all values in the subtree rooted at `current_node`,
                // find the smallest missing positive integer.
                // `current_next_missing` is incremented only if the value is found in `current_set`.
                // The total number of increments across all nodes on the path is at most N+1.
                while current_set.contains(&current_next_missing) {
                    current_next_missing += 1;
                }
                ans[current_node] = current_next_missing;

                // Move to the parent node.
                if parents[current_node] == -1 {
                    break; // Reached the root (node 0)
                }
                prev_node_on_path = Some(current_node); // Keep track of the child that leads upwards
                current_node = parents[current_node] as usize;
            }
        }

        ans
    }
}