var maximalNetworkRank = function(n, roads) {
    const degree = new Array(n).fill(0);
    const connected = new Array(n).fill().map(() => new Array(n).fill(false));

    for (const [a, b] of roads) {
        degree[a]++;
        degree[b]++;
        connected[a][b] = true;
        connected[b][a] = true;
    }

    let maxRank = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let rank = degree[i] + degree[j];
            if (connected[i][j]) {
                rank--;
            }
            maxRank = Math.max(maxRank, rank);
        }
    }

    return maxRank;
};