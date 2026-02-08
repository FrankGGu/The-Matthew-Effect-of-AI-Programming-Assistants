impl Solution {
    pub fn count_sub_trees(n: i32, edges: Vec<Vec<i32>>, labels: String) -> Vec<i32> {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let labels: Vec<char> = labels.chars().collect();
        let mut result: Vec<i32> = vec![0; n];

        fn dfs(
            node: usize,
            parent: usize,
            adj: &Vec<Vec<usize>>,
            labels: &Vec<char>,
            result: &mut Vec<i32>,
        ) -> Vec<i32> {
            let mut counts: Vec<i32> = vec![0; 26];
            counts[(labels[node] as u8 - b'a') as usize] = 1;

            for &neighbor in &adj[node] {
                if neighbor != parent {
                    let child_counts = dfs(neighbor, node, adj, labels, result);
                    for i in 0..26 {
                        counts[i] += child_counts[i];
                    }
                }
            }

            result[node] = counts[(labels[node] as u8 - b'a') as usize];
            counts
        }

        dfs(0, n, &adj, &labels, &mut result);

        result
    }
}