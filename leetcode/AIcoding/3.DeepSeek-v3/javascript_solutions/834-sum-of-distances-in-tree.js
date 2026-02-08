var sumOfDistancesInTree = function(n, edges) {
    const graph = new Array(n).fill().map(() => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const count = new Array(n).fill(1);
    const res = new Array(n).fill(0);

    const dfs1 = (node, parent) => {
        for (const child of graph[node]) {
            if (child === parent) continue;
            dfs1(child, node);
            count[node] += count[child];
            res[node] += res[child] + count[child];
        }
    };

    const dfs2 = (node, parent) => {
        for (const child of graph[node]) {
            if (child === parent) continue;
            res[child] = res[node] - count[child] + (n - count[child]);
            dfs2(child, node);
        }
    };

    dfs1(0, -1);
    dfs2(0, -1);

    return res;
};