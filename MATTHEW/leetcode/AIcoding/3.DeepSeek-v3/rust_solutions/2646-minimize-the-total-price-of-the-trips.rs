use std::collections::HashMap;

impl Solution {
    pub fn minimum_total_price(n: i32, edges: Vec<Vec<i32>>, price: Vec<i32>, trips: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut cnt = vec![0; n];
        for trip in trips {
            let start = trip[0] as usize;
            let end = trip[1] as usize;
            let mut parent = vec![None; n];
            let mut stack = vec![start];
            parent[start] = Some(start);
            while let Some(u) = stack.pop() {
                if u == end {
                    break;
                }
                for &v in &adj[u] {
                    if parent[v].is_none() {
                        parent[v] = Some(u);
                        stack.push(v);
                    }
                }
            }
            let mut path = vec![];
            let mut u = end;
            while u != start {
                path.push(u);
                u = parent[u].unwrap();
            }
            path.push(start);
            for &node in &path {
                cnt[node] += 1;
            }
        }

        fn dfs(u: usize, parent: usize, adj: &Vec<Vec<usize>>, price: &Vec<i32>, cnt: &Vec<i32>, dp: &mut HashMap<(usize, bool), i32>, halved: bool) -> i32 {
            if let Some(&res) = dp.get(&(u, halved)) {
                return res;
            }
            let mut res = price[u] * cnt[u];
            if halved {
                res /= 2;
            }
            let mut child_res = 0;
            for &v in &adj[u] {
                if v != parent {
                    if halved {
                        child_res += dfs(v, u, adj, price, cnt, dp, false);
                    } else {
                        child_res += std::cmp::min(dfs(v, u, adj, price, cnt, dp, false), dfs(v, u, adj, price, cnt, dp, true));
                    }
                }
            }
            res += child_res;
            dp.insert((u, halved), res);
            res
        }

        let mut dp = HashMap::new();
        std::cmp::min(dfs(0, 0, &adj, &price, &cnt, &mut dp, false), dfs(0, 0, &adj, &price, &cnt, &mut dp, true))
    }
}