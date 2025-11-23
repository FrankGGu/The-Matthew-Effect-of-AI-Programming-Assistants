function numberOfGoodPaths(values, edges) {
    const n = values.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const valueToNodes = new Map();
    for (let i = 0; i < n; i++) {
        if (!valueToNodes.has(values[i])) {
            valueToNodes.set(values[i], []);
        }
        valueToNodes.get(values[i]).push(i);
    }

    const parent = Array.from({ length: n }, (_, i) => i);
    const rank = Array(n).fill(1);

    function find(u) {
        while (parent[u] !== u) {
            parent[u] = parent[parent[u]];
            u = parent[u];
        }
        return u;
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU === rootV) return;
        if (rank[rootU] < rank[rootV]) {
            parent[rootU] = rootV;
            rank[rootV] += rank[rootU];
        } else {
            parent[rootV] = rootU;
            rank[rootU] += rank[rootV];
        }
    }

    const sortedValues = [...new Set(values)].sort((a, b) => a - b);
    const count = Array(n).fill(1);

    for (const val of sortedValues) {
        const nodes = valueToNodes.get(val);
        for (const node of nodes) {
            for (const neighbor of graph[node]) {
                if (values[neighbor] <= val) {
                    union(node, neighbor);
                }
            }
        }

        const map = new Map();
        for (const node of nodes) {
            const root = find(node);
            map.set(root, (map.get(root) || 0) + 1);
        }

        for (const [_, c] of map) {
            count[0] += c * (c - 1) / 2;
        }
    }

    return count[0];
}