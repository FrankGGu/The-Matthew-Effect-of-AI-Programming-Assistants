var sumOfDistancesInTree = function(n, edges) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const count = Array(n).fill(1);
    const ans = Array(n).fill(0);

    function dfs1(node, parent) {
        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                dfs1(neighbor, node);
                count[node] += count[neighbor];
                ans[node] += ans[neighbor] + count[neighbor];
            }
        }
    }

    function dfs2(node, parent) {
        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                ans[neighbor] = ans[node] - count[neighbor] + (n - count[neighbor]);
                dfs2(neighbor, node);
            }
        }
    }

    dfs1(0, -1);
    dfs2(0, -1);

    return ans;
};