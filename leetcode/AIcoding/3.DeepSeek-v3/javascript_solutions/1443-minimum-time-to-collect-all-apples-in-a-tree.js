var minTime = function(n, edges, hasApple) {
    const tree = new Array(n).fill().map(() => []);
    for (const [a, b] of edges) {
        tree[a].push(b);
        tree[b].push(a);
    }

    const visited = new Set();
    const dfs = (node) => {
        visited.add(node);
        let time = 0;
        for (const child of tree[node]) {
            if (!visited.has(child)) {
                const childTime = dfs(child);
                if (childTime > 0 || hasApple[child]) {
                    time += childTime + 2;
                }
            }
        }
        return time;
    };

    return dfs(0);
};