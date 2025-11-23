var maximumPoints = function(n, edges, values) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxPoints = 0;

    function dfs(node, parent, path) {
        path.push(node);
        let currentPoints = 0;
        let seen = new Set();
        for (let i = 0; i < path.length; i++) {
            if (!seen.has(path[i])) {
                currentPoints += values[path[i]];
                seen.add(path[i]);
            }
        }
        maxPoints = Math.max(maxPoints, currentPoints);

        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                dfs(neighbor, node, [...path]);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        dfs(i, -1, []);
    }

    return maxPoints;
};