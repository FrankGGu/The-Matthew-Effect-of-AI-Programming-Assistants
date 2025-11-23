function countUnreachablePairs(n, edges) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = new Array(n).fill(false);
    const sizes = [];

    function dfs(node) {
        let size = 1;
        visited[node] = true;
        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                size += dfs(neighbor);
            }
        }
        return size;
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            sizes.push(dfs(i));
        }
    }

    let total = 0;
    let sum = 0;
    for (const size of sizes) {
        total += sum * size;
        sum += size;
    }

    return total;
}