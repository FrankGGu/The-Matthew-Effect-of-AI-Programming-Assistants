var largestPathValue = function(colors, edges) {
    const n = colors.length;
    const A_CHAR_CODE = 'a'.charCodeAt(0);
    const NUM_COLORS = 26;

    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
    }

    const dp = Array(n).fill(null); 
    const state = Array(n).fill(0); // 0: unvisited, 1: visiting, 2: visited

    let hasCycle = false;
    let maxColorValue = 0;

    const dfs = (u) => {
        state[u] = 1; // Mark as visiting

        const current_dp_values = Array(NUM_COLORS).fill(0);

        for (const v of adj[u]) {
            if (state[v] === 1) { // Cycle detected
                hasCycle = true;
                return;
            }
            if (state[v] === 0) { // Unvisited neighbor
                dfs(v);
                if (hasCycle) { // Propagate cycle detection
                    return;
                }
            }
            // If state[v] === 2 (fully visited) or just finished dfs(v), dp[v] is ready.
            // Merge counts from paths ending at v.
            for (let k = 0; k < NUM_COLORS; k++) {
                current_dp_values[k] = Math.max(current_dp_values[k], dp[v][k]);
            }
        }

        current_dp_values[colors.charCodeAt(u) - A_CHAR_CODE]++;

        dp[u] = current_dp_values; 
        state[u] = 2; // Mark as fully visited

        maxColorValue = Math.max(maxColorValue, Math.max(...dp[u]));
    };

    for (let i = 0; i < n; i++) {
        if (state[i] === 0) {
            dfs(i);
            if (hasCycle) {
                return -1;
            }
        }
    }

    return maxColorValue;
};