class MinPriorityQueue {
    constructor() {
        this.elements = [];
    }

    enqueue(element, priority) {
        this.elements.push({ element, priority });
        this.elements.sort((a, b) => a.priority - b.priority); // Simple sort, for small N
    }

    dequeue() {
        if (this.isEmpty()) {
            return null;
        }
        return this.elements.shift();
    }

    isEmpty() {
        return this.elements.length === 0;
    }
}

var modifyGraphEdgeWeights = function(n, edges, source, destination, target) {
    const resultEdges = edges.map(([u, v, w]) => [u, v, w]); // Copy of edges
    const negEdgeIndices = [];

    // Identify -1 edges
    for (let i = 0; i < edges.length; i++) {
        if (edges[i][2] === -1) {
            negEdgeIndices.push(i);
        }
    }

    // Helper function for Dijkstra
    const dijkstra = (startNode, currentEdges) => {
        const currentAdj = Array.from({ length: n }, () => []);
        for (let i = 0; i < currentEdges.length; i++) {
            const [u, v, w] = currentEdges[i];
            currentAdj[u].push([v, w, i]);
            currentAdj[v].push([u, w, i]); // Graph is undirected
        }

        const dists = new Array(n).fill(Infinity);
        dists[startNode] = 0;
        const pq = new MinPriorityQueue();
        pq.enqueue(startNode, 0);

        while (!pq.isEmpty()) {
            const { element: u, priority: d } = pq.dequeue();

            if (d > dists[u]) {
                continue;
            }

            for (const [v, weight] of currentAdj[u]) {
                if (dists[u] + weight < dists[v]) {
                    dists[v] = dists[u] + weight;
                    pq.enqueue(v, dists[v]);
                }
            }
        }
        return dists;
    };

    // --- Phase 1: Calculate minimum possible path length (all -1 edges as 1) ---
    const tempEdges1 = edges.map(([u, v, w]) => [u, v, (w === -1) ? 1 : w]);
    const distsFromSource1 = dijkstra(source, tempEdges1);
    const minPathLen = distsFromSource1[destination];

    // --- Check minPathLen ---
    if (minPathLen > target) {
        return []; // Impossible to reach target even with minimum weights
    }

    if (minPathLen === target) {
        // All -1 edges on path are 1, others are 1. This works.
        for (const idx of negEdgeIndices) {
            resultEdges[idx][2] = 1;
        }
        return resultEdges;
    }

    // --- Phase 2: minPathLen < target (Need to increase weights) ---
    // We need to add diffNeeded to one -1 edge to make the path length target.
    const diffNeeded = target - minPathLen;

    // Iterate through each -1 edge and try to assign diffNeeded to it.
    // All other -1 edges are set to 1.
    for (const negIdxToModify of negEdgeIndices) {
        const tempEdges = edges.map(([u, v, w]) => [u, v, w]); // Fresh copy

        for (const idx of negEdgeIndices) {
            if (idx === negIdxToModify) {
                tempEdges[idx][2] = 1 + diffNeeded;
            } else {
                tempEdges[idx][2] = 1;
            }
        }

        const currentDists = dijkstra(source, tempEdges);

        if (currentDists[destination] === target) {
            // Found a valid configuration.
            // Update resultEdges permanently and return.
            for (const idx of negEdgeIndices) {
                if (idx === negIdxToModify) {
                    resultEdges[idx][2] = 1 + diffNeeded;
                } else {
                    resultEdges[idx][2] = 1;
                }
            }
            return resultEdges;
        }
    }

    // If no configuration worked in Phase 2, it's impossible.
    return [];
};