var numberOfGoodPaths = function(vals, edges) {
    const n = vals.length;
    const parent = Array.from({ length: n }, (_, i) => i);
    const size = Array(n).fill(1);
    const graph = Array.from({ length: n }, () => []);
    const valueCount = new Map();

    edges.forEach(([u, v]) => {
        graph[u].push(v);
        graph[v].push(u);
    });

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
            if (size[rootX] < size[rootY]) {
                parent[rootX] = rootY;
                size[rootY] += size[rootX];
            } else {
                parent[rootY] = rootX;
                size[rootX] += size[rootY];
            }
        }
    };

    const nodes = Array.from({ length: n }, (_, i) => [vals[i], i]).sort((a, b) => a[0] - b[0]);

    let goodPaths = 0;

    for (let i = 0; i < n; i++) {
        const [value, node] = nodes[i];
        valueCount.set(value, (valueCount.get(value) || 0) + 1);

        for (const neighbor of graph[node]) {
            if (vals[neighbor] <= value) {
                union(node, neighbor);
            }
        }

        const root = find(node);
        const count = valueCount.get(value);
        goodPaths += count * (count + 1) / 2;
    }

    return goodPaths;
};