var openingCeremonyFireworks = function(fireworks, relations) {
    const n = fireworks.length;
    const adj = new Array(n).fill(0).map(() => []);

    for (const [u, v] of relations) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const distinctValues = new Set();

    function dfs(node, parent, parentValue) {
        if (node === 0 || fireworks[node] !== parentValue) {
            distinctValues.add(fireworks[node]);

            for (const neighbor of adj[node]) {
                if (neighbor !== parent) {
                    dfs(neighbor, node, fireworks[node]);
                }
            }
        }
    }

    dfs(0, -1, -1);

    return distinctValues.size;
};