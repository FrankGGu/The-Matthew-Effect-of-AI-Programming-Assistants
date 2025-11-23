var minTime = function(n, edges, hasApple) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const dfs = (node, parent) => {
        let totalTime = 0;
        for (const neighbor of graph.get(node)) {
            if (neighbor !== parent) {
                totalTime += dfs(neighbor, node);
            }
        }
        if ((totalTime > 0 || hasApple[node]) && node !== 0) {
            totalTime += 2;
        }
        return totalTime;
    };

    return dfs(0, -1);
};