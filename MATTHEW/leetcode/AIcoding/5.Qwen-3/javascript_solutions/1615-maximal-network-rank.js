function maximalNetworkRank(n, roads) {
    const degree = new Array(n).fill(0);
    const connected = new Set();

    for (const [a, b] of roads) {
        degree[a]++;
        degree[b]++;
        connected.add(a + ',' + b);
        connected.add(b + ',' + a);
    }

    let maxRank = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (!connected.has(i + ',' + j)) {
                maxRank = Math.max(maxRank, degree[i] + degree[j]);
            }
        }
    }

    return maxRank;
}