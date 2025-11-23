var reachableNodes = function(edges, maxMoves, n) {
    const graph = new Map();
    for (const [u, v, cnt] of edges) {
        if (!graph.has(u)) graph.set(u, new Map());
        if (!graph.has(v)) graph.set(v, new Map());
        graph.get(u).set(v, cnt);
        graph.get(v).set(u, cnt);
    }

    const pq = new MaxPriorityQueue();
    pq.enqueue([0, 0]);
    const visited = new Set();
    const reachable = new Set();

    while (!pq.isEmpty()) {
        const [moves, node] = pq.dequeue().element;
        if (visited.has(node)) continue;
        visited.add(node);
        reachable.add(node);

        for (const [neighbor, cnt] of graph.get(node) || []) {
            if (!visited.has(neighbor)) {
                const newMoves = moves + cnt + 1;
                if (newMoves <= maxMoves) {
                    pq.enqueue([newMoves, neighbor]);
                }
            }
        }
    }

    return reachable.size;
};