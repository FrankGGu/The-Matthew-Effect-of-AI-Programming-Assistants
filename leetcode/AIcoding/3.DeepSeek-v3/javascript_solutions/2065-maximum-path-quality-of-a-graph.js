var maximalPathQuality = function(values, edges, maxTime) {
    const n = values.length;
    const graph = new Array(n).fill().map(() => []);
    for (const [u, v, t] of edges) {
        graph[u].push([v, t]);
        graph[v].push([u, t]);
    }

    let maxQuality = 0;
    const visited = new Array(n).fill(0);
    visited[0] = 1;

    function dfs(node, time, quality) {
        if (node === 0) {
            maxQuality = Math.max(maxQuality, quality);
        }

        for (const [neighbor, t] of graph[node]) {
            if (time + t <= maxTime) {
                if (visited[neighbor] === 0) {
                    visited[neighbor]++;
                    dfs(neighbor, time + t, quality + values[neighbor]);
                    visited[neighbor]--;
                } else {
                    dfs(neighbor, time + t, quality);
                }
            }
        }
    }

    dfs(0, 0, values[0]);
    return maxQuality;
};