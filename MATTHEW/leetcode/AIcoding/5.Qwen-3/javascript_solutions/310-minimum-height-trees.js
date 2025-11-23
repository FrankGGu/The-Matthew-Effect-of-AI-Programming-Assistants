function findMinHeightTrees(n, edges) {
    if (n === 1) return [0];

    const adj = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const leaves = [];
    for (let i = 0; i < n; i++) {
        if (adj[i].length === 1) {
            leaves.push(i);
        }
    }

    while (n > 2) {
        const size = leaves.length;
        n -= size;

        for (let i = 0; i < size; i++) {
            const leaf = leaves.shift();
            for (const neighbor of adj[leaf]) {
                adj[neighbor].splice(adj[neighbor].indexOf(leaf), 1);
                if (adj[neighbor].length === 1) {
                    leaves.push(neighbor);
                }
            }
        }
    }

    return leaves;
}