var waysToReconstructTree = function(pairs) {
    const adj = new Map();

    for (const [u, v] of pairs) {
        if (!adj.has(u)) adj.set(u, new Set());
        if (!adj.has(v)) adj.set(v, new Set());
        adj.get(u).add(v);
        adj.get(v).add(u);
    }

    const nodes = Array.from(adj.keys());
    const n = nodes.length;

    const degree = {};
    for (const node of nodes) {
        degree[node] = adj.get(node).size;
    }

    const root = nodes.find(node => degree[node] === 1);
    if (!root) return 0;

    const visited = new Set();
    const queue = [root];
    visited.add(root);

    while (queue.length > 0) {
        const node = queue.shift();
        for (const neighbor of adj.get(node)) {
            if (!visited.has(neighbor)) {
                visited.add(neighbor);
                queue.push(neighbor);
            }
        }
    }

    if (visited.size !== n) return 0;

    const count = {};
    for (const [u, v] of pairs) {
        count[u] = (count[u] || 0) + 1;
        count[v] = (count[v] || 0) + 1;
    }

    for (const node of nodes) {
        if (count[node] !== degree[node]) return 0;
    }

    let result = 1;
    for (const node of nodes) {
        if (degree[node] > 1) {
            result *= degree[node] - 1;
        }
    }

    return result;
};