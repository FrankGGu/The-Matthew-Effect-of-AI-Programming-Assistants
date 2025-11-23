impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn earliest_and_latest(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut memo = HashMap::new();

        fn dfs(node: usize, parent: usize, graph: &Vec<Vec<usize>>, memo: &mut HashMap<(usize, usize), (i32, i32)>) -> (i32, i32) {
            if let Some(&res) = memo.get(&(node, parent)) {
                return res;
            }

            let mut min_round = i32::MAX;
            let mut max_round = i32::MIN;

            for &child in &graph[node] {
                if child == parent {
                    continue;
                }

                let (min_child, max_child) = dfs(child, node, graph, memo);

                min_round = min_round.min(min_child + 1);
                max_round = max_round.max(max_child + 1);
            }

            if min_round == i32::MAX {
                min_round = 0;
                max_round = 0;
            }

            memo.insert((node, parent), (min_round, max_round));
            (min_round, max_round)
        }

        let (min_round, max_round) = dfs(0, n, &graph, &mut memo);
        vec![min_round, max_round]
    }
}
}