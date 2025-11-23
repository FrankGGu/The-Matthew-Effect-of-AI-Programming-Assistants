var isPossible = function(n, edges) {
    const degree = new Array(n + 1).fill(0);
    const adj = new Array(n + 1).fill().map(() => new Set());

    for (const [u, v] of edges) {
        degree[u]++;
        degree[v]++;
        adj[u].add(v);
        adj[v].add(u);
    }

    const oddNodes = [];
    for (let i = 1; i <= n; i++) {
        if (degree[i] % 2 !== 0) {
            oddNodes.push(i);
        }
    }

    if (oddNodes.length === 0) {
        return true;
    }

    if (oddNodes.length === 2) {
        const [a, b] = oddNodes;
        if (!adj[a].has(b)) {
            return true;
        }
        for (let i = 1; i <= n; i++) {
            if (i !== a && i !== b && !adj[a].has(i) && !adj[b].has(i)) {
                return true;
            }
        }
        return false;
    }

    if (oddNodes.length === 4) {
        const [a, b, c, d] = oddNodes;
        return (
            (!adj[a].has(b) && !adj[c].has(d)) ||
            (!adj[a].has(c) && !adj[b].has(d)) ||
            (!adj[a].has(d) && !adj[b].has(c))
    }

    return false;
};