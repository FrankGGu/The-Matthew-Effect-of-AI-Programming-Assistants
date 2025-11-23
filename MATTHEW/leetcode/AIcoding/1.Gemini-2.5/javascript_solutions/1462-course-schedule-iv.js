var checkIfPrerequisite = function(n, prerequisites, queries) {
    const reachable = Array(n).fill(0).map(() => Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        reachable[i][i] = true;
    }

    for (const [u, v] of prerequisites) {
        reachable[u][v] = true;
    }

    for (let k = 0; k < n; k++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                reachable[i][j] = reachable[i][j] || (reachable[i][k] && reachable[k][j]);
            }
        }
    }

    const results = [];
    for (const [u, v] of queries) {
        results.push(reachable[u][v]);
    }

    return results;
};