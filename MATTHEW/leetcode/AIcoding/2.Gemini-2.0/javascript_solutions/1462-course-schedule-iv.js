var checkIfPrerequisite = function(n, prerequisites, queries) {
    const adj = Array(n).fill(null).map(() => []);
    const reachable = Array(n).fill(null).map(() => Array(n).fill(false));

    for (const [u, v] of prerequisites) {
        adj[u].push(v);
    }

    for (let i = 0; i < n; i++) {
        const q = [i];
        const visited = new Set();
        visited.add(i);
        reachable[i][i] = true;

        while (q.length > 0) {
            const u = q.shift();

            for (const v of adj[u]) {
                if (!visited.has(v)) {
                    visited.add(v);
                    reachable[i][v] = true;
                    q.push(v);
                }
            }
        }
    }

    const result = [];
    for (const [u, v] of queries) {
        result.push(reachable[u][v]);
    }

    return result;
};