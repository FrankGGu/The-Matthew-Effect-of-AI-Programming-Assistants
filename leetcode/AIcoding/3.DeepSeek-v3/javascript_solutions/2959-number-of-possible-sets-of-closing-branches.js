var numberOfSets = function(n, maxDistance, roads) {
    let res = 0;
    const dist = Array.from({ length: n }, () => Array(n).fill(Infinity));
    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
    }
    for (const [u, v, w] of roads) {
        if (w < dist[u][v]) {
            dist[u][v] = w;
            dist[v][u] = w;
        }
    }

    for (let mask = 0; mask < (1 << n); mask++) {
        const nodes = [];
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                nodes.push(i);
            }
        }
        if (check(nodes, dist, maxDistance)) {
            res++;
        }
    }
    return res;
};

function check(nodes, dist, maxDistance) {
    const k = nodes.length;
    const d = Array.from({ length: k }, () => Array(k).fill(Infinity));
    for (let i = 0; i < k; i++) {
        d[i][i] = 0;
        for (let j = i + 1; j < k; j++) {
            d[i][j] = dist[nodes[i]][nodes[j]];
            d[j][i] = d[i][j];
        }
    }

    for (let m = 0; m < k; m++) {
        for (let i = 0; i < k; i++) {
            for (let j = 0; j < k; j++) {
                if (d[i][m] + d[m][j] < d[i][j]) {
                    d[i][j] = d[i][m] + d[m][j];
                }
            }
        }
    }

    for (let i = 0; i < k; i++) {
        for (let j = 0; j < k; j++) {
            if (d[i][j] > maxDistance) {
                return false;
            }
        }
    }
    return true;
}