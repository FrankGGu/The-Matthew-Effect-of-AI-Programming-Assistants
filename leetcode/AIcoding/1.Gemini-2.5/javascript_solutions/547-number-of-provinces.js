var findCircleNum = function(isConnected) {
    const n = isConnected.length;
    let provinces = 0;
    const visited = new Array(n).fill(false);

    function dfs(u) {
        visited[u] = true;
        for (let v = 0; v < n; v++) {
            if (isConnected[u][v] === 1 && !visited[v]) {
                dfs(v);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            provinces++;
            dfs(i);
        }
    }

    return provinces;
};