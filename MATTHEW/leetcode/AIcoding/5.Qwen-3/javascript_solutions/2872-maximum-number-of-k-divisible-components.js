function maxKDivisibleComponents(n, edges, values, k) {
    let result = 0;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    function dfs(node, parent) {
        let sum = values[node];
        for (const neighbor of graph[node]) {
            if (neighbor === parent) continue;
            sum += dfs(neighbor, node);
        }
        if (sum % k === 0) result++;
        return sum;
    }

    dfs(0, -1);
    return result;
}