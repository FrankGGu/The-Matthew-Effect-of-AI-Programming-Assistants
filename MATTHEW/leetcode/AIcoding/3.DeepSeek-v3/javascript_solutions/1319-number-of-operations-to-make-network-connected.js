var makeConnected = function(n, connections) {
    if (connections.length < n - 1) return -1;

    const parent = Array(n).fill().map((_, i) => i);

    const find = (u) => {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    };

    let components = n;

    for (const [u, v] of connections) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            parent[rootV] = rootU;
            components--;
        }
    }

    return components - 1;
};