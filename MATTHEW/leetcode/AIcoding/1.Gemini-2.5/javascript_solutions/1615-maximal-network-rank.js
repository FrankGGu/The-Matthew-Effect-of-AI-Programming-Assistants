var maximalNetworkRank = function(n, roads) {
    const degree = new Array(n).fill(0);
    const adj = Array(n).fill(0).map(() => Array(n).fill(false));

    for (const [u, v] of roads) {
        degree[u]++;
        degree[v]++;
        adj[u][v] = true;
        adj[v][u] = true;
    }

    let maxRank = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let currentRank = degree[i] + degree[j];
            if (adj[i][j]) {
                currentRank--;
            }
            maxRank = Math.max(maxRank, currentRank);
        }
    }

    return maxRank;
};