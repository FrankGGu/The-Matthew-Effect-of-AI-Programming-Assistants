function reachableNodes(n, edges, restricted) {
    const graph = new Map();
    for (let i = 0; i < n; i++) {
        graph.set(i, []);
    }
    for (const [u, v] of edges) {
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const restrictedSet = new Set(restricted);
    const visited = new Set();
    const queue = [0];
    visited.add(0);

    while (queue.length > 0) {
        const node = queue.shift();
        for (const neighbor of graph.get(node)) {
            if (!visited.has(neighbor) && !restrictedSet.has(neighbor)) {
                visited.add(neighbor);
                queue.push(neighbor);
            }
        }
    }

    return visited.size;
}