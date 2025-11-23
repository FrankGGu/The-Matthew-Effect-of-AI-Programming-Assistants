var minCostConnectPoints = function(points) {
    const n = points.length;
    const edges = [];
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const cost = Math.abs(points[i][0] - points[j][0]) + Math.abs(points[i][1] - points[j][1]);
            edges.push([i, j, cost]);
        }
    }
    edges.sort((a, b) => a[2] - b[2]);

    const parent = Array(n).fill().map((_, i) => i);
    const find = (u) => {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    };

    let res = 0;
    let count = 0;
    for (const [u, v, cost] of edges) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            parent[rootU] = rootV;
            res += cost;
            count++;
            if (count === n - 1) break;
        }
    }
    return res;
};