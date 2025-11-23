impl Solution {
    pub fn count_sub_trees(n: i32, edges: Vec<Vec<i32>>, labels: String) -> Vec<i32> {
        let n = n as usize;
        let labels_chars: Vec<char> = labels.chars().collect();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans: Vec<i32> = vec![0; n];

        fn dfs(
            u: usize,
            p: usize,
            adj: &[Vec<usize>],
            labels: &[char],
            ans: &mut [i32],
        ) -> [i32; 26] {
            let mut counts = [0; 26];

            let label_idx = (labels[u] as u8 - b'a') as usize;
            counts[label_idx] = 1;

            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                let child_counts = dfs(v, u, adj, labels, ans);
                for i in 0..26 {
                    counts[i] += child_counts[i];
                }
            }

            ans[u] = counts[label_idx];

            counts
        }

        dfs(0, n, &adj, &labels_chars, &mut ans);

        ans
    }
}