var maxKDivisibleComponents = function(n, edges, values, k) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let res = 0;

    const dfs = (node, parent) => {
        let sum = values[node];
        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                sum += dfs(neighbor, node);
            }
        }
        if (sum % k === 0) {
            res++;
            return 0;
        }
        return sum;
    };

    dfs(0, -1);
    return res;
};