var minGuards = function(grid) {
    const m = grid.length;
    if (m === 0) return 0;
    const n = grid[0].length;
    if (n === 0) return 0;

    const adj = Array(m).fill(0).map(() => []);
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                adj[i].push(j);
            }
        }
    }

    const matchC = Array(n).fill(-1);

    let maxMatching = 0;

    function dfs(u, visited) {
        visited[u] = true;

        for (const v of adj[u]) {
            if (matchC[v] === -1 || (!visited[matchC[v]] && dfs(matchC[v], visited))) {
                matchC[v] = u;
                return true;
            }
        }
        return false;
    }

    for (let i = 0; i < m; i++) {
        const visited = Array(m).fill(false);
        if (dfs(i, visited)) {
            maxMatching++;
        }
    }

    return maxMatching;
};