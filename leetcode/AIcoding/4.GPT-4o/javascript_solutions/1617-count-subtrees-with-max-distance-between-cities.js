var countSubgraphsForEachDiameter = function(n, edges) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const result = new Array(n - 1).fill(0);

    const dfs = (node, visited, depth) => {
        visited.add(node);
        let maxDepth = depth;
        for (const neighbor of graph[node]) {
            if (!visited.has(neighbor)) {
                maxDepth = Math.max(maxDepth, dfs(neighbor, visited, depth + 1));
            }
        }
        visited.delete(node);
        return maxDepth;
    };

    const count = (mask) => {
        const visited = new Set();
        let maxDiameter = 0;
        let countNodes = 0;

        for (let i = 1; i <= n; i++) {
            if ((mask & (1 << (i - 1))) !== 0) {
                countNodes++;
                const diameter = dfs(i, new Set());
                maxDiameter = Math.max(maxDiameter, diameter);
            }
        }

        return countNodes > 1 ? maxDiameter : 0;
    };

    for (let mask = 1; mask < (1 << n); mask++) {
        const diameter = count(mask);
        if (diameter > 0) {
            result[diameter - 1]++;
        }
    }

    return result;
};