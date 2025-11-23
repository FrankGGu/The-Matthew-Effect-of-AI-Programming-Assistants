var checkWays = function(pairs) {
    const graph = new Map();
    for (const [u, v] of pairs) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const roots = [...graph.keys()].filter(k => graph.get(k).length === 1);
    if (roots.length !== 1) return 0;

    const root = roots[0];
    const visited = new Set();

    const dfs = (node) => {
        visited.add(node);
        const children = graph.get(node).filter(n => !visited.has(n));
        let count = 1;
        for (const child of children) {
            count *= dfs(child);
        }
        return count * (children.length === 0 ? 1 : children.length);
    };

    return dfs(root) === pairs.length + 1 ? 1 : 0;
};