var minOperationsQueries = function(n, edges, queries) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const parent = new Array(n).fill(-1);
    const depth = new Array(n).fill(0);
    const weightCount = Array.from({ length: n }, () => new Array(27).fill(0));
    const stack = [[0, -1, 0]];
    while (stack.length) {
        const [u, p, d] = stack.pop();
        parent[u] = p;
        depth[u] = d;
        for (const [v, w] of adj[u]) {
            if (v !== p) {
                for (let i = 0; i < 27; i++) {
                    weightCount[v][i] = weightCount[u][i];
                }
                weightCount[v][w]++;
                stack.push([v, u, d + 1]);
            }
        }
    }

    const lca = (u, v) => {
        while (u !== v) {
            if (depth[u] > depth[v]) {
                u = parent[u];
            } else {
                v = parent[v];
            }
        }
        return u;
    };

    const res = [];
    for (const [u, v] of queries) {
        const ancestor = lca(u, v);
        const total = depth[u] + depth[v] - 2 * depth[ancestor];
        let maxFreq = 0;
        for (let i = 1; i <= 26; i++) {
            const cnt = weightCount[u][i] + weightCount[v][i] - 2 * weightCount[ancestor][i];
            maxFreq = Math.max(maxFreq, cnt);
        }
        res.push(total - maxFreq);
    }
    return res;
};