var criticalConnections = function(n, connections) {
    const graph = new Array(n).fill().map(() => []);
    for (const [u, v] of connections) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const discovery = new Array(n).fill(-1);
    const low = new Array(n).fill(-1);
    const result = [];
    let time = 0;

    function dfs(u, parent) {
        discovery[u] = low[u] = time++;

        for (const v of graph[u]) {
            if (v === parent) continue;

            if (discovery[v] === -1) {
                dfs(v, u);
                low[u] = Math.min(low[u], low[v]);
                if (low[v] > discovery[u]) {
                    result.push([u, v]);
                }
            } else {
                low[u] = Math.min(low[u], discovery[v]);
            }
        }
    }

    dfs(0, -1);
    return result;
};