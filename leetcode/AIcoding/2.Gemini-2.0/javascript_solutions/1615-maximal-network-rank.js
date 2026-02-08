var maximalNetworkRank = function(n, roads) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of roads) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxRank = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let rank = adj[i].length + adj[j].length;
            if (adj[i].includes(j)) {
                rank--;
            }
            maxRank = Math.max(maxRank, rank);
        }
    }

    return maxRank;
};