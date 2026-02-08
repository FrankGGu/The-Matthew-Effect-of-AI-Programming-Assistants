var sumOfDistancesInTree = function(n, edges) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const count = new Array(n).fill(0);
    const sum_dist = new Array(n).fill(0);
    const ans = new Array(n).fill(0);

    function dfs1(u, p) {
        count[u] = 1;
        sum_dist[u] = 0;
        for (const v of adj[u]) {
            if (v === p) continue;
            dfs1(v, u);
            count[u] += count[v];
            sum_dist[u] += sum_dist[v] + count[v];
        }
    }

    function dfs2(u, p) {
        for (const v of adj[u]) {
            if (v === p) continue;
            ans[v] = ans[u] - count[v] + (n - count[v]);
            dfs2(v, u);
        }
    }

    dfs1(0, -1);
    ans[0] = sum_dist[0];
    dfs2(0, -1);

    return ans;
};