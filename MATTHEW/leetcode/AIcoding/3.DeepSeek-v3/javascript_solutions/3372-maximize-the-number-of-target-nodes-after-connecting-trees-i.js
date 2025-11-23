var maximumTargetNodes = function(n, edges, k) {
    const adj = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxCount = 0;

    const dfs = (node, parent, depth) => {
        let count = 0;
        if (depth <= k) {
            count++;
        }
        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                count += dfs(neighbor, node, depth + 1);
            }
        }
        return count;
    };

    for (let i = 1; i <= n; i++) {
        const currentCount = dfs(i, -1, 0);
        if (currentCount > maxCount) {
            maxCount = currentCount;
        }
    }

    return maxCount;
};