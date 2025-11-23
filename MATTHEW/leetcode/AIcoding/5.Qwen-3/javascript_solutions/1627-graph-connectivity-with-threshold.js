function areConnected(n, queries) {
    const parent = Array(n).fill(0).map((_, i) => i);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            parent[rootV] = rootU;
        }
    }

    for (let i = 1; i <= n; i++) {
        for (let j = i * 2; j <= n; j += i) {
            union(i - 1, j - 1);
        }
    }

    const result = [];
    for (const [u, v, threshold] of queries) {
        const rootU = find(u - 1);
        const rootV = find(v - 1);
        result.push(rootU === rootV);
    }

    return result;
}