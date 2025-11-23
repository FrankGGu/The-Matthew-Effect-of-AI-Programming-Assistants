impl Solution {
    pub fn placed_coins(edges: Vec<Vec<i32>>, cost: Vec<i32>) -> i64 {
        let n = cost.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans = 0;

        fn dfs(u: usize, p: usize, adj: &Vec<Vec<usize>>, cost: &Vec<i32>, ans: &mut i64) -> (Vec<i64>, Vec<i64>) {
            let mut pos: Vec<i64> = vec![cost[u].max(0) as i64];
            let mut neg: Vec<i64> = vec![cost[u].min(0) as i64];

            for &v in &adj[u] {
                if v != p {
                    let (child_pos, child_neg) = dfs(v, u, adj, cost, ans);
                    pos.extend(child_pos);
                    neg.extend(child_neg);
                }
            }

            pos.sort_unstable_by(|a, b| b.cmp(a));
            neg.sort_unstable();

            let mut max_prod = i64::MIN;

            if pos.len() >= 2 {
                max_prod = max_prod.max(pos[0] * pos[1]);
            }
            if neg.len() >= 2 {
                max_prod = max_prod.max(neg[0] * neg[1]);
            }

            if max_prod != i64::MIN {
                *ans += max_prod;
            }

            let mut new_pos: Vec<i64> = Vec::new();
            let mut new_neg: Vec<i64> = Vec::new();

            for i in 0..pos.len().min(2) {
                new_pos.push(pos[i]);
            }
            for i in 0..neg.len().min(2) {
                new_neg.push(neg[i]);
            }

            (new_pos, new_neg)
        }

        dfs(0, usize::MAX, &adj, &cost, &mut ans);

        ans
    }
}