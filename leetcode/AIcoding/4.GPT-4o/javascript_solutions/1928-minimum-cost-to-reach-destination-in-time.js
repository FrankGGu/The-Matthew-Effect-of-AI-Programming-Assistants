var minCost = function(maxTime, edges, passingFees) {
    const graph = new Map();
    for (const [u, v, t] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push([v, t]);
        graph.get(v).push([u, t]);
    }

    const pq = new MinPriorityQueue();
    const costs = new Map();
    costs.set(1, passingFees[0]);
    pq.enqueue([1, passingFees[0], 0]);

    while (!pq.isEmpty()) {
        const [node, cost, time] = pq.dequeue().element;
        if (node === edges.length) return cost;
        for (const [neighbor, travelTime] of (graph.get(node) || [])) {
            const newTime = time + travelTime;
            const newCost = cost + passingFees[neighbor - 1];
            if (newTime <= maxTime && (!costs.has(neighbor) || newCost < costs.get(neighbor))) {
                costs.set(neighbor, newCost);
                pq.enqueue([neighbor, newCost, newTime]);
            }
        }
    }
    return -1;
};