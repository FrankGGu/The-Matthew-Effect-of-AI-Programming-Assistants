var getAncestors = function(n, edges) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(v)) graph.set(v, []);
        graph.get(v).push(u);
    }

    const ancestors = Array.from({ length: n }, () => new Set());

    const dfs = (node, visited) => {
        if (visited.has(node)) return;
        visited.add(node);
        if (graph.has(node)) {
            for (const ancestor of graph.get(node)) {
                ancestors[node].add(ancestor);
                dfs(ancestor, visited);
                for (const anc of ancestors[ancestor]) {
                    ancestors[node].add(anc);
                }
            }
        }
    };

    for (let i = 0; i < n; i++) {
        dfs(i, new Set());
    }

    return ancestors.map(set => Array.from(set).sort((a, b) => a - b));
};