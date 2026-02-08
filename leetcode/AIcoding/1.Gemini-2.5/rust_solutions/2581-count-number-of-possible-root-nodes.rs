use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn count_rooted_trees(n: i32, edges: Vec<Vec<i32>>, guesses: Vec<Vec<i32>>, k: i32) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut guesses_set: HashSet<(i32, i32)> = HashSet::new();
        for guess in guesses {
            guesses_set.insert((guess[0], guess[1]));
        }

        let mut dp_subtree_correct: Vec<i32> = vec![0; n_usize];
        let mut ans: Vec<i32> = vec![0; n_usize];

        // DFS1: Calculate dp_subtree_correct[u] for all u.
        // dp_subtree_correct[u] stores the number of correct guesses (x, y)
        // where x is an ancestor of y, and both x, y are within the subtree rooted at u
        // (when u is considered a child of its parent p).
        // After this DFS, dp_subtree_correct[0] will hold the total correct guesses
        // if node 0 is chosen as the root.
        fn dfs1(
            u: usize,
            p: usize,
            adj: &Vec<Vec<usize>>,
            guesses_set: &HashSet<(i32, i32)>,
            dp_subtree_correct: &mut Vec<i32>,
        ) {
            let mut current_subtree_count = 0;
            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                // If (u, v) is a guess, it's correct when u is parent of v
                if guesses_set.contains(&(u as i32, v as i32)) {
                    current_subtree_count += 1;
                }
                dfs1(v, u, adj, guesses_set, dp_subtree_correct);
                current_subtree_count += dp_subtree_correct[v];
            }
            dp_subtree_correct[u] = current_subtree_count;
        }

        dfs1(0, n_usize, &adj, &guesses_set, &mut dp_subtree_correct);
        ans[0] = dp_subtree_correct[0];

        // DFS2: Rerooting DP to calculate ans[u] for all u.
        // ans[u] is the total number of correct guesses if u is the root.
        fn dfs2(
            u: usize,
            p: usize,
            adj: &Vec<Vec<usize>>,
            guesses_set: &HashSet<(i32, i32)>,
            ans: &mut Vec<i32>,
        ) {
            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                ans[v] = ans[u];
                // When moving root from u to v:
                // If (u, v) was a guess: it was correct (u parent of v).
                // Now v is root, u is child of v, so (u, v) becomes incorrect. Loss of 1.
                if guesses_set.contains(&(u as i32, v as i32)) {
                    ans[v] -= 1;
                }
                // If (v, u) was a guess: it was incorrect (v child of u).
                // Now v is root, u is child of v, so (v, u) becomes correct. Gain of 1.
                if guesses_set.contains(&(v as i32, u as i32)) {
                    ans[v] += 1;
                }
                dfs2(v, u, adj, guesses_set, ans);
            }
        }

        dfs2(0, n_usize, &adj, &guesses_set, &mut ans);

        let mut possible_roots_count = 0;
        for i in 0..n_usize {
            if ans[i] >= k {
                possible_roots_count += 1;
            }
        }

        possible_roots_count
    }
}