var maxOutput = function(n, edges, price) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let res = 0;

    function dfs(node, parent) {
        let max1 = 0, max2 = 0;
        for (const neighbor of adj[node]) {
            if (neighbor === parent) continue;
            const childMax = dfs(neighbor, node);
            if (childMax > max1) {
                max2 = max1;
                max1 = childMax;
            } else if (childMax > max2) {
                max2 = childMax;
            }
        }
        res = Math.max(res, max1 + max2);
        return max1 + price[node];
    }

    dfs(0, -1);
    return res;
};