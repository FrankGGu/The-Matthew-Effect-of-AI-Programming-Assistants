var minReorder = function(n, connections) {
    let adj = new Array(n).fill(null).map(() => []);
    for (let [u, v] of connections) {
        adj[u].push([v, 1]);
        adj[v].push([u, 0]);
    }

    let visited = new Array(n).fill(false);
    let count = 0;

    function dfs(node) {
        visited[node] = true;
        for (let [neighbor, cost] of adj[node]) {
            if (!visited[neighbor]) {
                count += cost;
                dfs(neighbor);
            }
        }
    }

    dfs(0);
    return count;
};