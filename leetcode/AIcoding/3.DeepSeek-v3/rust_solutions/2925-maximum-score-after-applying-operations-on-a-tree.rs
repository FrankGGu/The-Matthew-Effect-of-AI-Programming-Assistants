use std::collections::HashMap;

impl Solution {
    pub fn maximum_score_after_operations(edges: Vec<Vec<i32>>, values: Vec<i32>) -> i64 {
        let n = values.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut memo: HashMap<(usize, bool), i64> = HashMap::new();

        fn dfs(
            u: usize,
            parent: usize,
            must_keep: bool,
            adj: &Vec<Vec<usize>>,
            values: &Vec<i32>,
            memo: &mut HashMap<(usize, bool), i64>,
        ) -> i64 {
            if let Some(&res) = memo.get(&(u, must_keep)) {
                return res;
            }

            let mut total = 0;
            let mut children = vec![];
            for &v in &adj[u] {
                if v != parent {
                    children.push(v);
                }
            }

            if must_keep {
                total = values[u] as i64;
                for &v in &children {
                    total += dfs(v, u, true, adj, values, memo);
                }
            } else {
                let option1 = values[u] as i64;
                for &v in &children {
                    option1 += dfs(v, u, false, adj, values, memo);
                }

                let option2 = 0;
                let mut all_kept = true;
                for &v in &children {
                    let child_score = dfs(v, u, true, adj, values, memo);
                    if child_score == 0 {
                        all_kept = false;
                        break;
                    }
                }
                if all_kept && !children.is_empty() {
                    option2 = 0;
                    for &v in &children {
                        option2 += dfs(v, u, true, adj, values, memo);
                    }
                } else {
                    option2 = 0;
                    for &v in &children {
                        option2 += dfs(v, u, false, adj, values, memo);
                    }
                }

                total = option1.max(option2);
            }

            memo.insert((u, must_keep), total);
            total
        }

        let total_sum: i64 = values.iter().map(|&x| x as i64).sum();
        let min_kept = dfs(0, usize::MAX, false, &adj, &values, &mut memo);
        total_sum - min_kept
    }
}