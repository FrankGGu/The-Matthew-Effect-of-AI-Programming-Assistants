var eventualSafeNodes = function(graph) {
    const n = graph.length;
    const color = new Array(n).fill(0);
    const safeNodes = [];

    const dfs = (node) => {
        if (color[node] !== 0) return color[node];
        color[node] = 1; // visiting
        for (const neighbor of graph[node]) {
            if (dfs(neighbor) === 1) {
                return color[node] = 1; // found a cycle
            }
        }
        return color[node] = 2; // safe
    };

    for (let i = 0; i < n; i++) {
        dfs(i);
    }

    for (let i = 0; i < n; i++) {
        if (color[i] === 2) safeNodes.push(i);
    }

    return safeNodes;
};