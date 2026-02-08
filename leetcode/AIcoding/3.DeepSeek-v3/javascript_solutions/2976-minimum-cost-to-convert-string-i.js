var minimumCost = function(source, target, original, changed, cost) {
    const INF = 1e18;
    const dist = Array.from({ length: 26 }, () => Array(26).fill(INF));
    for (let i = 0; i < 26; i++) {
        dist[i][i] = 0;
    }
    for (let i = 0; i < original.length; i++) {
        const u = original[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const v = changed[i].charCodeAt(0) - 'a'.charCodeAt(0);
        if (cost[i] < dist[u][v]) {
            dist[u][v] = cost[i];
        }
    }
    for (let k = 0; k < 26; k++) {
        for (let i = 0; i < 26; i++) {
            for (let j = 0; j < 26; j++) {
                if (dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }
    let totalCost = 0;
    for (let i = 0; i < source.length; i++) {
        const u = source.charCodeAt(i) - 'a'.charCodeAt(0);
        const v = target.charCodeAt(i) - 'a'.charCodeAt(0);
        if (u === v) continue;
        if (dist[u][v] === INF) return -1;
        totalCost += dist[u][v];
    }
    return totalCost;
};