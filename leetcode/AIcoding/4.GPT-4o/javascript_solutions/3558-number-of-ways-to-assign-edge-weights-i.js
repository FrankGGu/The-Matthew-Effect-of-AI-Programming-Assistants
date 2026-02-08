var countWays = function(edges) {
    const mod = 1e9 + 7;
    const n = edges.length + 1;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const dfs = (node, parent) => {
        let totalWays = 1;
        let childCount = 0;

        for (const neighbor of graph[node]) {
            if (neighbor === parent) continue;
            const [ways, count] = dfs(neighbor, node);
            totalWays = (totalWays * ways) % mod;
            childCount += count;
        }

        return [totalWays * (childCount + 1) % mod, childCount + 1];
    };

    return dfs(0, -1)[0];
};