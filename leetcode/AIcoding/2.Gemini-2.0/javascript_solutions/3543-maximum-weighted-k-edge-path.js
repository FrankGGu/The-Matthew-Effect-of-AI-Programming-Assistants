var maxWeightKEdgePath = function(n, edges, k) {
    let adj = Array(n).fill(null).map(() => []);
    for (let [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    let maxWeight = -1;

    function dfs(node, visited, currentWeight, pathLength) {
        visited[node] = true;

        if (pathLength === k) {
            maxWeight = Math.max(maxWeight, currentWeight);
            visited[node] = false;
            return;
        }

        for (let [neighbor, weight] of adj[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, visited, currentWeight + weight, pathLength + 1);
            }
        }

        visited[node] = false;
    }

    for (let startNode = 0; startNode < n; startNode++) {
        let visited = Array(n).fill(false);
        dfs(startNode, visited, 0, 0);
    }

    return maxWeight;
};