var criticalConnections = function(n, connections) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of connections) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const disc = new Array(n).fill(-1);
    const low = new Array(n).fill(-1);
    const result = [];
    let time = 0;

    function dfs(u, parent) {
        disc[u] = low[u] = time++;

        for (const v of adj[u]) {
            if (v === parent) {
                continue;
            }

            if (disc[v] === -1) {
                dfs(v, u);
                low[u] = Math.min(low[u], low[v]);
                if (disc[u] < low[v]) {
                    result.push([u, v]);
                }
            } else {
                low[u] = Math.min(low[u], disc[v]);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (disc[i] === -1) {
            dfs(i, -1);
        }
    }

    return result;
};