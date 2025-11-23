var maximalPathQuality = function(values, edges, maxTime) {
    const n = values.length;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    let maxQuality = 0;
    const visited = Array(n).fill(0);

    function dfs(node, currentTime, currentQuality) {
        visited[node]++;
        currentQuality += (visited[node] === 1) ? values[node] : 0;

        if (node === 0) {
            maxQuality = Math.max(maxQuality, currentQuality);
        }

        for (const [neighbor, weight] of adj[node]) {
            if (currentTime + weight <= maxTime) {
                dfs(neighbor, currentTime + weight, currentQuality);
            }
        }

        visited[node]--;
    }

    dfs(0, 0, 0);
    return maxQuality;
};