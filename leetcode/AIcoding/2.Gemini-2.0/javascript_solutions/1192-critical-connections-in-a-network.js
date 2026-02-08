var criticalConnections = function(n, connections) {
    let graph = Array(n).fill(null).map(() => []);
    for (let [u, v] of connections) {
        graph[u].push(v);
        graph[v].push(u);
    }

    let disc = Array(n).fill(-1);
    let low = Array(n).fill(-1);
    let time = 0;
    let result = [];

    function dfs(node, parent) {
        disc[node] = low[node] = time++;

        for (let neighbor of graph[node]) {
            if (neighbor === parent) continue;

            if (disc[neighbor] === -1) {
                dfs(neighbor, node);
                low[node] = Math.min(low[node], low[neighbor]);

                if (low[neighbor] > disc[node]) {
                    result.push([node, neighbor]);
                }
            } else {
                low[node] = Math.min(low[node], disc[neighbor]);
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