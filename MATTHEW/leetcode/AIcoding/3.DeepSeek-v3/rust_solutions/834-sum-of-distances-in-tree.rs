use std::collections::HashSet;

impl Solution {
    pub fn sum_of_distances_in_tree(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![HashSet::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].insert(v);
            graph[v].insert(u);
        }

        let mut count = vec![1; n];
        let mut res = vec![0; n];

        fn dfs(
            node: usize,
            parent: usize,
            graph: &Vec<HashSet<usize>>,
            count: &mut Vec<i32>,
            res: &mut Vec<i32>,
        ) {
            for &child in &graph[node] {
                if child != parent {
                    dfs(child, node, graph, count, res);
                    count[node] += count[child];
                    res[node] += res[child] + count[child];
                }
            }
        }

        fn dfs2(
            node: usize,
            parent: usize,
            n: usize,
            graph: &Vec<HashSet<usize>>,
            count: &Vec<i32>,
            res: &mut Vec<i32>,
        ) {
            for &child in &graph[node] {
                if child != parent {
                    res[child] = res[node] - count[child] + (n as i32 - count[child]);
                    dfs2(child, node, n, graph, count, res);
                }
            }
        }

        dfs(0, usize::MAX, &graph, &mut count, &mut res);
        dfs2(0, usize::MAX, n, &graph, &count, &mut res);

        res
    }
}