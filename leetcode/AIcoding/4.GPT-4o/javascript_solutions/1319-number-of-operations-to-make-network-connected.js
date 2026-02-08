var makeConnected = function(n, connections) {
    if (connections.length < n - 1) return -1;

    const parent = Array(n).fill(0).map((_, i) => i);

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
            parent[rootY] = rootX;
        }
    };

    for (const [u, v] of connections) {
        union(u, v);
    }

    const components = new Set();
    for (let i = 0; i < n; i++) {
        components.add(find(i));
    }

    return components.size - 1;
};