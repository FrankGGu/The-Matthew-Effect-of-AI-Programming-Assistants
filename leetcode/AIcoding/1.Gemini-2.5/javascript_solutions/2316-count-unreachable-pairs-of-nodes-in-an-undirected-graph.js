var countPairs = function(n, edges) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const visited = Array(n).fill(false);
    let unreachablePairs = 0n;
    let remainingNodes = n;

    const dfs = (node, currentComponentSize) => {
        visited[node] = true;
        currentComponentSize++;
        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                currentComponentSize = dfs(neighbor, currentComponentSize);
            }
        }
        return currentComponentSize;
    };

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            const currentComponentSize = dfs(i, 0);
            unreachablePairs += BigInt(currentComponentSize) * BigInt(remainingNodes - currentComponentSize);
            remainingNodes -= currentComponentSize;
        }
    }

    return unreachablePairs;
};