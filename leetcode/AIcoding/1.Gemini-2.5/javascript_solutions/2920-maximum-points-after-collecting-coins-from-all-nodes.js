function maximumPoints(n, edges, coins, k) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    // Maximum number of divisions to consider.
    // log2(10^4) is approximately 13.28. So, 14 divisions are enough to make any coin value 0.
    const MAX_DIVISIONS = 14; 

    // memo[node][divisions_count] stores the maximum points from the subtree rooted at 'node',
    // given that the coins at 'node' have already been divided 'divisions_count' times.
    const memo = Array(n).fill(0).map(() => Array(MAX_DIVISIONS + 1).fill(-1));

    function dfs(u, p, d) {
        // If the result for this state is already computed, return it.
        if (memo[u][d] !== -1) {
            return memo[u][d];
        }

        // Option 1: Don't divide coins[u] further.
        // The points collected from 'u' are coins[u] / (2^d).
        let sumChildrenPoints1 = 0;
        for (const v of adj[u]) {
            if (v === p) continue; // Skip parent
            sumChildrenPoints1 += dfs(v, u, d); // Children also inherit 'd' divisions
        }
        const choice1 = Math.floor(coins[u] / (1 << d)) + sumChildrenPoints1;

        // Option 2: Divide coins[u] one more time.
        // The points collected from 'u' are coins[u] / (2^(d+1)) - k.
        // Cap the number of divisions at MAX_DIVISIONS to prevent out-of-bounds access
        // and to reflect that further divisions past MAX_DIVISIONS will still result in 0 coins.
        const next_d = Math.min(d + 1, MAX_DIVISIONS); 
        let sumChildrenPoints2 = 0;
        for (const v of adj[u]) {
            if (v === p) continue; // Skip parent
            sumChildrenPoints2 += dfs(v, u, next_d); // Children inherit 'd+1' divisions
        }
        const choice2 = Math.floor(coins[u] / (1 << next_d)) - k + sumChildrenPoints2;

        // Store and return the maximum of the two choices.
        return memo[u][d] = Math.max(choice1, choice2);
    }

    // Start DFS from node 0 (arbitrary root), with no parent (-1), and 0 initial divisions.
    return dfs(0, -1, 0);
}