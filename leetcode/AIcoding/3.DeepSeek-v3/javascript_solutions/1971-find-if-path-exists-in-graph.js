var validPath = function(n, edges, source, destination) {
    if (source === destination) return true;

    const graph = new Map();
    for (let i = 0; i < n; i++) {
        graph.set(i, []);
    }

    for (const [u, v] of edges) {
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const visited = new Set();
    const queue = [source];
    visited.add(source);

    while (queue.length > 0) {
        const current = queue.shift();
        for (const neighbor of graph.get(current)) {
            if (neighbor === destination) {
                return true;
            }
            if (!visited.has(neighbor)) {
                visited.add(neighbor);
                queue.push(neighbor);
            }
        }
    }

    return false;
};