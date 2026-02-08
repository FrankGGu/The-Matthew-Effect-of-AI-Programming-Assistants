var numberOfWays = function(n, edges, weights) {
    const MOD = 10**9 + 7;

    // Helper function to calculate factorial modulo MOD
    const factorial = (k) => {
        let res = 1;
        for (let i = 2; i <= k; i++) {
            res = (res * i) % MOD;
        }
        return res;
    };

    // Adjacency list for the graph
    const adj = Array(n + 1).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    // Variables for bridge-finding DFS
    const visited = Array(n + 1).fill(false);
    const discovery_time = Array(n + 1).fill(0);
    const low_link_value = Array(n + 1).fill(0);
    let time = 0;
    let bridge_count = 0;

    // DFS function to find bridges
    const dfs = (u, parent) => {
        visited[u] = true;
        discovery_time[u] = low_link_value[u] = time++;

        for (const v of adj[u]) {
            if (v === parent) {
                continue;
            }
            if (visited[v]) {
                // Back-edge: update low_link_value of u
                low_link_value[u] = Math.min(low_link_value[u], discovery_time[v]);
            } else {
                // Tree-edge: recurse on v
                dfs(v, u);
                // After recursion, update low_link_value of u based on v's subtree
                low_link_value[u] = Math.min(low_link_value[u], low_link_value[v]);
                // If low_link_value of v is greater than discovery_time of u, (u, v) is a bridge
                if (low_link_value[v] > discovery_time[u]) {
                    bridge_count++;
                }
            }
        }
    };

    // Iterate through all nodes to handle disconnected components
    for (let i = 1; i <= n; i++) {
        if (!visited[i]) {
            dfs(i, -1); // -1 indicates no parent for the root of a DFS tree
        }
    }

    const m = edges.length; // Total number of edges
    const k = bridge_count; // Number of bridges

    // The number of ways is (number of bridges)! * (number of non-bridges)!
    // This is because the k largest weights must be assigned to the k bridges
    // to maximize the minimum bottleneck capacity, and the remaining m-k weights
    // to the m-k non-bridges.
    const fact_k = factorial(k);
    const fact_m_minus_k = factorial(m - k);

    return (fact_k * fact_m_minus_k) % MOD;
};