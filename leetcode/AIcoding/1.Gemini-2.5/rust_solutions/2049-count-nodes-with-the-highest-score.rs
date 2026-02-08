impl Solution {
    pub fn count_highest_score_nodes(parents: Vec<i32>) -> i32 {
        let n = parents.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];

        for i in 1..n {
            adj[parents[i] as usize].push(i);
        }

        let mut subtree_sizes: Vec<usize> = vec![0; n];

        fn dfs_subtree_size(
            u: usize,
            adj: &Vec<Vec<usize>>,
            subtree_sizes: &mut Vec<usize>,
        ) -> usize {
            let mut current_size = 1;
            for &v in &adj[u] {
                current_size += dfs_subtree_size(v, adj, subtree_sizes);
            }
            subtree_sizes[u] = current_size;
            current_size
        }

        dfs_subtree_size(0, &adj, &mut subtree_sizes);

        let mut max_score: i64 = 0;
        let mut count: i32 = 0;

        for i in 0..n {
            let mut current_score: i64 = 1;

            // Component above node i
            let remaining_nodes = n - subtree_sizes[i];
            if remaining_nodes > 0 {
                current_score *= remaining_nodes as i64;
            }

            // Components of children's subtrees
            for &child in &adj[i] {
                current_score *= subtree_sizes[child] as i64;
            }

            if current_score > max_score {
                max_score = current_score;
                count = 1;
            } else if current_score == max_score {
                count += 1;
            }
        }

        count
    }
}