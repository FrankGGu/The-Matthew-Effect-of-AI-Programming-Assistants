var subtreeSizes = function(n, edges, queries) {
    const tree = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        tree[u].push(v);
        tree[v].push(u);
    }

    const parent = new Array(n + 1).fill(0);
    const size = new Array(n + 1).fill(1);

    function dfs(u, p) {
        parent[u] = p;
        for (const v of tree[u]) {
            if (v !== p) {
                dfs(v, u);
                size[u] += size[v];
            }
        }
    }
    dfs(1, 0);

    const res = [];
    for (const [u, v] of queries) {
        if (parent[u] === v) {
            const originalSize = size[u];
            size[v] -= originalSize;
            size[u] += size[v];
            parent[u] = 0;
            parent[v] = u;
        } else if (parent[v] === u) {
            const originalSize = size[v];
            size[u] -= originalSize;
            size[v] += size[u];
            parent[v] = 0;
            parent[u] = v;
        }
        res.push(size[1]);
    }
    return res;
};