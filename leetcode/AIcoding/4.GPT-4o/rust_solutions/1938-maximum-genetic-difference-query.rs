struct Solution;

impl Solution {
    pub fn max_genetic_difference(parents: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = parents.len();
        let mut max_diff = vec![0; n];
        let mut graph = vec![vec![]; n];

        for (i, &p) in parents.iter().enumerate() {
            if p != -1 {
                graph[p as usize].push(i);
            }
        }

        fn dfs(node: usize, graph: &Vec<Vec<usize>>, max_diff: &mut Vec<i32>, parent: i32) {
            for &child in &graph[node] {
                max_diff[child] = max_diff[node] ^ (1 << (node % 32));
                dfs(child, graph, max_diff, node as i32);
            }
        }

        dfs(0, &graph, &mut max_diff, -1);

        let mut results = vec![0; queries.len()];

        for (i, q) in queries.iter().enumerate() {
            results[i] = max_diff[q[0] as usize] ^ max_diff[q[1] as usize];
        }

        results
    }
}