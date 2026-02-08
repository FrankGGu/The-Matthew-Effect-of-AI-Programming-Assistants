function makeConnected(n, connections) {
    if (connections.length < n - 1) return -1;

    const parent = Array(n).fill(0).map((_, i) => i);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX === rootY) return false;
        parent[rootY] = rootX;
        return true;
    }

    for (const [x, y] of connections) {
        union(x, y);
    }

    const roots = new Set();
    for (let i = 0; i < n; i++) {
        roots.add(find(i));
    }

    return roots.size - 1;
}