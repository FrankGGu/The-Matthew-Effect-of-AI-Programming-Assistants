struct Solution;

impl Solution {
    pub fn maximum_points(edges: Vec<Vec<i32>>, coins: Vec<i32>, cost: Vec<i32>) -> i64 {
        let n = coins.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        // MAX_K_VAL represents the maximum number of times coins can be halved before they effectively become 0.
        // max_coins is 10^4. log2(10^4) is approximately 13.28.
        // So, if k = 14, 1 << k = 16384. coins[u] / (1 << 14) will be 0 for coins[u] <= 10^4.
        // Thus, k can range from 0 to 14. A total of 15 states for k.
        const MAX_K_VAL: usize = 14; 
        let mut memo: Vec<Vec<Option<i64>>> = vec![vec![None; MAX_K_VAL + 1]; n];

        Self::dfs(0, n, 0, &adj, &coins, &cost, &mut memo)
    }

    fn dfs(
        u: usize,
        parent: usize,
        k: usize,
        adj: &Vec<Vec<usize>>,
        coins: &Vec<i32>,
        cost: &Vec<i32>,
        memo: &mut Vec<Vec<Option<i64>>>,
    ) -> i64 {
        if k > MAX_K_VAL {
            return 0; // If k exceeds MAX_K_VAL, coins[u] / (1 << k) will be 0, so no points can be gained.
        }
        if let Some(val) = memo[u][k] {
            return val;
        }

        let current_coins_at_u = coins[u] / (1 << k);

        // Choice 1: Collect current_coins_at_u coins
        let mut points1 = current_coins_at_u as i64 - cost[u] as i64;
        for &v in &adj[u] {
            if v == parent {
                continue;
            }
            // According to problem statement, coins[u] value is then halved for all its children.
            // This means k increases by 1 for children regardless of action 1 or 2.
            points1 += Self::dfs(v, u, k + 1, adj, coins, cost, memo);
        }

        // Choice 2: Collect current_coins_at_u / 2 coins
        let mut points2 = (current_coins_at_u / 2) as i64 - cost[u] as i64;
        for &v in &adj[u] {
            if v == parent {
                continue;
            }
            // k increases by 1 for children.
            points2 += Self::dfs(v, u, k + 1, adj, coins, cost, memo);
        }

        // Choice 3: Do not collect coins
        let mut points3 = 0i64;
        for &v in &adj[u] {
            if v == parent {
                continue;
            }
            // The problem statement "The coins[u] value is then halved for all its children"
            // appears for all three actions. This implies k increases by 1 for children
            // even if we don't collect coins at node u.
            points3 += Self::dfs(v, u, k + 1, adj, coins, cost, memo);
        }

        let result = points1.max(points2).max(points3);
        memo[u][k] = Some(result);
        result
    }
}