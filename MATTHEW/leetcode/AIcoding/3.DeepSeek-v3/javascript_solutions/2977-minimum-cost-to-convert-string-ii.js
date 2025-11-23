var minimumCost = function(source, target, original, changed, cost) {
    const INF = Number.MAX_SAFE_INTEGER;
    const CHAR_SET_SIZE = 26;
    const dist = Array.from({ length: CHAR_SET_SIZE }, () => Array(CHAR_SET_SIZE).fill(INF));

    for (let i = 0; i < CHAR_SET_SIZE; i++) {
        dist[i][i] = 0;
    }

    for (let i = 0; i < original.length; i++) {
        const u = original[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const v = changed[i].charCodeAt(0) - 'a'.charCodeAt(0);
        if (cost[i] < dist[u][v]) {
            dist[u][v] = cost[i];
        }
    }

    for (let k = 0; k < CHAR_SET_SIZE; k++) {
        for (let i = 0; i < CHAR_SET_SIZE; i++) {
            for (let j = 0; j < CHAR_SET_SIZE; j++) {
                if (dist[i][k] !== INF && dist[k][j] !== INF && dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    let totalCost = 0;
    for (let i = 0; i < source.length; i++) {
        const u = source[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const v = target[i].charCodeAt(0) - 'a'.charCodeAt(0);
        if (u === v) continue;
        if (dist[u][v] === INF) return -1;
        totalCost += dist[u][v];
    }

    return totalCost;
};