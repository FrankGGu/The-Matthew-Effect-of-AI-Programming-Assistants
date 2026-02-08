var countComponents = function(n, edges) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = new Array(n).fill(false);
    let components = 0;

    const dfs = (node) => {
        visited[node] = true;
        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor);
            }
        }
    };

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            components++;
            dfs(i);
        }
    }

    return components;
};