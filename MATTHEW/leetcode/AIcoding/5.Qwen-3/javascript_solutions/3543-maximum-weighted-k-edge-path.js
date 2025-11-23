function maxWeightKEdgePath(n, edges, k) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const dp = Array.from({ length: n }, () => Array(k + 1).fill(-Infinity));
    const visited = Array(n).fill(false);

    function dfs(node, steps) {
        if (steps === k) return 0;
        if (dp[node][steps] !== -Infinity) return dp[node][steps];

        let max = -Infinity;
        for (const [neighbor, weight] of graph[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                max = Math.max(max, weight + dfs(neighbor, steps + 1));
                visited[neighbor] = false;
            }
        }

        dp[node][steps] = max;
        return max;
    }

    let result = -Infinity;
    for (let i = 0; i < n; i++) {
        visited[i] = true;
        result = Math.max(result, dfs(i, 0));
        visited[i] = false;
    }

    return result;
}