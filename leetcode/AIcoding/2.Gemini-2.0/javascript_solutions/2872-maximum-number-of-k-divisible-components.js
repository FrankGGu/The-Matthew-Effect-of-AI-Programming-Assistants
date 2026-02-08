var maxKDivisibleComponents = function(n, edges, values, k) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let count = 0;
    const visited = Array(n).fill(false);

    function dfs(node) {
        visited[node] = true;
        let sum = values[node];

        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                sum += dfs(neighbor);
            }
        }
        return sum;
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            const sum = dfs(i);
            if (sum % k === 0) {
                count++;
            }
        }
    }

    return count;
};