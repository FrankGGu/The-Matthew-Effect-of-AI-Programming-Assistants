var getAncestors = function(n, edges) {
    const adj = Array(n).fill(null).map(() => []);
    const ancestors = Array(n).fill(null).map(() => new Set());

    for (const [u, v] of edges) {
        adj[v].push(u);
    }

    for (let i = 0; i < n; i++) {
        const visited = new Set();
        const queue = [i];
        visited.add(i);

        while (queue.length > 0) {
            const node = queue.shift();
            for (const neighbor of adj[node]) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    ancestors[i].add(neighbor);
                    queue.push(neighbor);
                }
            }
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        result.push(Array.from(ancestors[i]).sort((a, b) => a - b));
    }

    return result;
};