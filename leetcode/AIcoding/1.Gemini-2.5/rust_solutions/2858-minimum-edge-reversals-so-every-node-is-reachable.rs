struct Solution;

impl Solution {
    pub fn min_edge_reversals(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, bool)>> = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            // adj[u] stores (neighbor, original_direction_is_u_to_neighbor)
            // For original edge u -> v:
            adj[u].push((v, true));  // From u to v, the original direction is u -> v
            adj[v].push((u, false)); // From v to u, the original direction is NOT v -> u (it's u -> v)
        }

        let mut dp = vec![0; n];
        // dp[u] stores the number of reversals needed within the subtree rooted at u
        // to make all nodes in that subtree reachable from u.
        Self::dfs1(0, n, &adj, &mut dp);

        let mut ans = vec![0; n];
        // ans[u] stores the total number of reversals needed if u is the global root.
        ans[0] = dp[0]; // The cost for root 0 is simply its subtree cost (all nodes are in its subtree).
        Self::dfs2(0, n, &adj, &dp, &mut ans);

        let mut min_reversals = i32::MAX;
        for &val in &ans {
            min_reversals = min_reversals.min(val);
        }

        let mut result = Vec::new();
        for i in 0..n {
            if ans[i] == min_reversals {
                result.push(i as i32);
            }
        }

        result
    }

    // DFS1: Calculates dp[u] for each node u.
    // dp[u] = sum(dp[v] + cost_to_reach_v_from_u) for all children v.
    fn dfs1(u: usize, p: usize, adj: &Vec<Vec<(usize, bool)>>, dp: &mut Vec<i32>) {
        dp[u] = 0;
        for &(v, original_u_to_v) in &adj[u] {
            if v == p {
                continue;
            }
            Self::dfs1(v, u, adj, dp);
            if original_u_to_v {
                // Original edge was u -> v. To reach v from u, 0 reversals needed.
                dp[u] += dp[v];
            } else {
                // Original edge was v -> u. To reach v from u, 1 reversal needed (v->u becomes u->v).
                dp[u] += dp[v] + 1;
            }
        }
    }

    // DFS2: Calculates ans[u] for each node u using dp values and parent's ans.
    // This is a re-rooting DP step.
    fn dfs2(u: usize, p: usize, adj: &Vec<Vec<(usize, bool)>>, dp: &Vec<i32>, ans: &mut Vec<i32>) {
        for &(v, original_u_to_v) in &adj[u] {
            if v == p {
                continue;
            }
            // When moving the root from u to v:
            // The cost ans[u] includes the cost for the edge (u,v) and the subtree at v.
            // The new cost ans[v] can be derived from ans[u] by adjusting for the edge (u,v).

            if original_u_to_v {
                // Original edge was u -> v.
                // When u was root: u -> v contributed 0 cost (already in correct direction).
                // When v becomes root: u needs to be reachable from v, so v -> u is needed.
                // This means u -> v must be reversed, contributing 1 cost.
                // Net change in cost for this edge: +1 (from 0 to 1).
                ans[v] = ans[u] + 1;
            } else {
                // Original edge was v -> u.
                // When u was root: v -> u needed to be reversed to u -> v, contributed 1 cost.
                // When v becomes root: u needs to be reachable from v, so v -> u is needed.
                // This edge is already v -> u, so it contributes 0 cost.
                // Net change in cost for this edge: -1 (from 1 to 0).
                ans[v] = ans[u] - 1;
            }
            Self::dfs2(v, u, adj, dp, ans);
        }
    }
}