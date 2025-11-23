function maxTargetNodes(edges, reconnect) {
    const n = edges.length + 1;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const dfs = (node, parent) => {
        let count = 1;
        for (const child of graph[node]) {
            if (child !== parent) {
                count += dfs(child, node);
            }
        }
        return count;
    };

    const size = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        size[i] = dfs(i, -1);
    }

    const freq = new Map();
    for (let i = 0; i < n; i++) {
        freq.set(size[i], (freq.get(size[i]) || 0) + 1);
    }

    let max = 0;
    for (let i = 0; i < n; i++) {
        const s = size[i];
        const other = freq.get(s) - 1;
        max = Math.max(max, s + (reconnect > 0 ? (other > 0 ? other : 0) : 0));
    }

    return max;
}