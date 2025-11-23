var maxKDivisibleComponents = function(n, edges, k) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = new Array(n + 1).fill(false);
    let count = 0;

    const dfs = (node, currentSum) => {
        visited[node] = true;
        currentSum += node;

        if (currentSum % k === 0) {
            count++;
        }

        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, currentSum);
            }
        }

        visited[node] = false;
    };

    for (let i = 1; i <= n; i++) {
        if (!visited[i]) {
            dfs(i, 0);
        }
    }

    return count;
};