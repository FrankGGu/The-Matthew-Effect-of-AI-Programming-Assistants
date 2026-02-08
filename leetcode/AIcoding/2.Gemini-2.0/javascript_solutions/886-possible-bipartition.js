var possibleBipartition = function(n, dislikes) {
    const adj = Array(n + 1).fill(null).map(() => []);
    for (const [u, v] of dislikes) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const color = Array(n + 1).fill(0);

    function dfs(node, c) {
        color[node] = c;
        for (const neighbor of adj[node]) {
            if (color[neighbor] === 0) {
                if (!dfs(neighbor, -c)) {
                    return false;
                }
            } else if (color[neighbor] === c) {
                return false;
            }
        }
        return true;
    }

    for (let i = 1; i <= n; i++) {
        if (color[i] === 0) {
            if (!dfs(i, 1)) {
                return false;
            }
        }
    }

    return true;
};