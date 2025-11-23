var findCircleNum = function(isConnected) {
    const n = isConnected.length;
    const visited = new Array(n).fill(false);
    let count = 0;

    function dfs(node) {
        visited[node] = true;
        for (let i = 0; i < n; i++) {
            if (isConnected[node][i] === 1 && !visited[i]) {
                dfs(i);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
            count++;
        }
    }

    return count;
};