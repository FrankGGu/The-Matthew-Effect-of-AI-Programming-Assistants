var findCircleNum = function(isConnected) {
    const n = isConnected.length;
    let provinces = 0;
    const visited = new Array(n).fill(false);

    function dfs(city) {
        visited[city] = true;
        for (let neighbor = 0; neighbor < n; neighbor++) {
            if (isConnected[city][neighbor] === 1 && !visited[neighbor]) {
                dfs(neighbor);
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