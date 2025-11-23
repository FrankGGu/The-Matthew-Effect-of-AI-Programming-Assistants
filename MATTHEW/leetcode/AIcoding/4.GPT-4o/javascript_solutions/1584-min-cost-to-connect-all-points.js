var minCostConnectPoints = function(points) {
    const n = points.length;
    const edges = [];

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const cost = Math.abs(points[i][0] - points[j][0]) + Math.abs(points[i][1] - points[j][1]);
            edges.push([cost, i, j]);
        }
    }

    edges.sort((a, b) => a[0] - b[0]);

    const parent = Array(n).fill(0).map((_, index) => index);

    const find = (x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootX] = rootY;
            return true;
        }
        return false;
    };

    let cost = 0;
    let edgesUsed = 0;

    for (const [c, u, v] of edges) {
        if (union(u, v)) {
            cost += c;
            edgesUsed++;
            if (edgesUsed === n - 1) break;
        }
    }

    return cost;
};