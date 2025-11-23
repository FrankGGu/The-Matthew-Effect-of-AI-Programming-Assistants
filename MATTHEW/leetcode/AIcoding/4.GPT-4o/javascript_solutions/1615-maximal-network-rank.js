var maximalNetworkRank = function(n, roads) {
    const graph = Array(n).fill(0);
    const roadSet = new Set();

    for (const [u, v] of roads) {
        graph[u]++;
        graph[v]++;
        roadSet.add(u * n + v);
        roadSet.add(v * n + u);
    }

    let maxRank = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let rank = graph[i] + graph[j];
            if (roadSet.has(i * n + j)) {
                rank--;
            }
            maxRank = Math.max(maxRank, rank);
        }
    }

    return maxRank;
};