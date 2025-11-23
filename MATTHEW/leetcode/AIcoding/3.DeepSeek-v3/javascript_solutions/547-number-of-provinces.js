var findCircleNum = function(isConnected) {
    const n = isConnected.length;
    const visited = new Array(n).fill(false);
    let provinces = 0;

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            provinces++;
            dfs(i, visited, isConnected);
        }
    }

    return provinces;
};

function dfs(node, visited, isConnected) {
    visited[node] = true;
    for (let neighbor = 0; neighbor < isConnected.length; neighbor++) {
        if (isConnected[node][neighbor] === 1 && !visited[neighbor]) {
            dfs(neighbor, visited, isConnected);
        }
    }
}