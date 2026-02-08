impl Solution {
    pub fn maximum_points(edges: Vec<Vec<i32>>, coins: Vec<i32>, k: i32) -> i64 {
        let n = coins.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut memo: Vec<Vec<Option<i64>>> = vec![vec![None; 21]; n];

        fn dfs(
            node: usize,
            parent: usize,
            coins: &Vec<i32>,
            k: i32,
            adj: &Vec<Vec<usize>>,
            shift: usize,
            memo: &mut Vec<Vec<Option<i64>>>,
        ) -> i64 {
            if shift > 20 {
                return 0;
            }

            if let Some(val) = memo[node][shift] {
                return val;
            }

            let mut no_shift = (coins[node] as i64) / (1 << shift) - (k as i64);
            let mut shift_val = (coins[node] as i64) / (1 << (shift + 1));

            for &neighbor in &adj[node] {
                if neighbor != parent {
                    no_shift += dfs(neighbor, node, coins, k, adj, shift, memo);
                    shift_val += dfs(neighbor, node, coins, k, adj, shift + 1, memo);
                }
            }

            let result = no_shift.max(shift_val);
            memo[node][shift] = Some(result);
            result
        }

        dfs(0, usize::MAX, &coins, k, &adj, 0, &mut memo)
    }
}