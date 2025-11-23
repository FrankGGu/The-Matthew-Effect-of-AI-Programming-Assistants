function maxProbability(n, edges, succProb, start, end) {
    const graph = new Map();
    for (let i = 0; i < n; i++) {
        graph.set(i, []);
    }
    for (let i = 0; i < edges.length; i++) {
        const [u, v] = edges[i];
        graph.get(u).push([v, succProb[i]]);
        graph.get(v).push([u, succProb[i]]);
    }

    const prob = new Array(n).fill(0);
    prob[start] = 1;
    const visited = new Set();

    const queue = [start];
    while (queue.length > 0) {
        const current = queue.shift();
        visited.add(current);
        for (const [neighbor, p] of graph.get(current)) {
            if (!visited.has(neighbor) && prob[neighbor] < prob[current] * p) {
                prob[neighbor] = prob[current] * p;
                queue.push(neighbor);
            }
        }
    }

    return prob[end];
}