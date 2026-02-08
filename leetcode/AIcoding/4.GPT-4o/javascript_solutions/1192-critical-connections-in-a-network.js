var criticalConnections = function(n, connections) {
    const graph = new Map();
    for (const [u, v] of connections) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const result = [];
    const disc = new Array(n).fill(-1);
    const low = new Array(n).fill(-1);
    let time = 0;

    const dfs = (u, parent) => {
        disc[u] = low[u] = time++;
        for (const v of graph.get(u)) {
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
    };

    for (let i = 0; i < n; i++) {
        if (disc[i] === -1) {
            dfs(i, -1);
        }
    }

    return result;
};