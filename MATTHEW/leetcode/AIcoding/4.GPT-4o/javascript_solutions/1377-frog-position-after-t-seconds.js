var frogPosition = function(n, edges, time, target) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const dfs = (node, parent, t) => {
        if (t === 0) return node === target ? 1 : 0;
        if (node === target) {
            const childrenCount = graph.get(node).length - (parent === -1 ? 0 : 1);
            if (childrenCount === 0) return t === 0 ? 1 : 0;
            return 0;
        }

        let totalWays = 0;
        for (const neighbor of graph.get(node)) {
            if (neighbor !== parent) {
                totalWays += dfs(neighbor, node, t - 1);
            }
        }

        if (totalWays > 0) {
            const childrenCount = graph.get(node).length - (parent === -1 ? 0 : 1);
            return childrenCount > 0 ? 0 : 1;
        }

        return 0;
    };

    const result = dfs(1, -1, time);
    return result === 1 ? 1 : 0;
};