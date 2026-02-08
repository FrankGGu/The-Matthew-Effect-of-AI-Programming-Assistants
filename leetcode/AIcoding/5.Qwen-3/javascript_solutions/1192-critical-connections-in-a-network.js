function criticalConnections(n, edges) {
    const graph = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const disc = new Array(n).fill(-1);
    const low = new Array(n).fill(-1);
    const time = [0];
    const result = [];

    function dfs(u, parent) {
        disc[u] = low[u] = time[0]++;
        for (const v of graph[u]) {
            if (v === parent) continue;
            if (disc[v] === -1) {
                dfs(v, u);
                low[u] = Math.min(low[u], low[v]);
                if (low[v] > disc[u]) {
                    result.push([u, v]);
                }
            } else {
                low[u] = Math.min(low[u], disc[v]);
            }
        }
    }

    dfs(0, -1);
    return result;
}