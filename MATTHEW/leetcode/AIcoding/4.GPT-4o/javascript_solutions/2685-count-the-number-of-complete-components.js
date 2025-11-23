var countCompleteComponents = function(n, edges) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    let visited = new Array(n).fill(false);
    let completeCount = 0;

    const dfs = (node) => {
        visited[node] = true;
        let size = 1;
        let edgesCount = 0;
        for (const neighbor of graph[node]) {
            edgesCount++;
            if (!visited[neighbor]) {
                size += dfs(neighbor);
            }
        }
        return [size, edgesCount];
    };

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            const [size, edgesCount] = dfs(i);
            if (edgesCount / 2 === (size * (size - 1)) / 2) {
                completeCount++;
            }
        }
    }

    return completeCount;
};