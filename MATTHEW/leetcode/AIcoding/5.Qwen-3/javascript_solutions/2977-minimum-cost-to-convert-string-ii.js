function minimumCost(source, target, original, changed, cost) {
    const n = 26;
    const INF = Infinity;
    let dist = Array.from({ length: n }, () => Array(n).fill(INF));

    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
    }

    for (let i = 0; i < original.length; i++) {
        const u = original[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const v = changed[i].charCodeAt(0) - 'a'.charCodeAt(0);
        if (dist[u][v] > cost[i]) {
            dist[u][v] = cost[i];
        }
    }

    for (let k = 0; k < n; k++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    let total = 0;
    for (let i = 0; i < source.length; i++) {
        const s = source[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const t = target[i].charCodeAt(0) - 'a'.charCodeAt(0);
        if (dist[s][t] === INF) {
            return -1;
        }
        total += dist[s][t];
    }

    return total;
}