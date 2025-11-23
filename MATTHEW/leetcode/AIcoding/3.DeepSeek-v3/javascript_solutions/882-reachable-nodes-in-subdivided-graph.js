var reachableNodes = function(edges, maxMoves, n) {
    const graph = new Array(n).fill().map(() => new Map());
    for (const [u, v, cnt] of edges) {
        graph[u].set(v, cnt);
        graph[v].set(u, cnt);
    }

    const heap = new MinPriorityQueue({ priority: (node) => node.dist });
    heap.enqueue({ node: 0, dist: 0 });

    const dist = new Array(n).fill(Infinity);
    dist[0] = 0;

    const visited = new Set();
    let res = 0;

    while (!heap.isEmpty()) {
        const { node, dist: currentDist } = heap.dequeue().element;
        if (visited.has(node)) continue;
        visited.add(node);
        res++;

        for (const [neighbor, cnt] of graph[node]) {
            if (!visited.has(neighbor)) {
                const newDist = currentDist + cnt + 1;
                if (newDist < dist[neighbor]) {
                    dist[neighbor] = newDist;
                    heap.enqueue({ node: neighbor, dist: newDist });
                }
            }
        }
    }

    for (const [u, v, cnt] of edges) {
        const a = Math.max(0, maxMoves - dist[u]);
        const b = Math.max(0, maxMoves - dist[v]);
        res += Math.min(a + b, cnt);
    }

    return res;
};