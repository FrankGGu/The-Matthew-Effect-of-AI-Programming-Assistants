var maxProbability = function(n, edges, succProb, start, end) {
    const graph = new Map();
    for (let i = 0; i < edges.length; i++) {
        const [u, v] = edges[i];
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push([v, succProb[i]]);
        graph.get(v).push([u, succProb[i]]);
    }

    const pq = new MaxPriorityQueue();
    const probabilities = new Array(n).fill(0);
    probabilities[start] = 1;
    pq.enqueue(start, 1);

    while (!pq.isEmpty()) {
        const [node, prob] = pq.dequeue();
        if (node === end) return prob;

        for (const [neighbor, edgeProb] of graph.get(node) || []) {
            const newProb = prob * edgeProb;
            if (newProb > probabilities[neighbor]) {
                probabilities[neighbor] = newProb;
                pq.enqueue(neighbor, newProb);
            }
        }
    }
    return 0;
};