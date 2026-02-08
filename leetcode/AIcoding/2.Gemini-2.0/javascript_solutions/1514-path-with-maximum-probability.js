var maxProbability = function(n, edges, succProb, start, end) {
    const adj = new Array(n).fill(null).map(() => []);
    for (let i = 0; i < edges.length; i++) {
        const [u, v] = edges[i];
        adj[u].push({ node: v, prob: succProb[i] });
        adj[v].push({ node: u, prob: succProb[i] });
    }

    const dist = new Array(n).fill(0);
    dist[start] = 1;
    const pq = [{ node: start, prob: 1 }];

    while (pq.length > 0) {
        pq.sort((a, b) => b.prob - a.prob);
        const { node, prob } = pq.shift();

        if (prob < dist[node]) continue;

        for (const neighbor of adj[node]) {
            const newProb = prob * neighbor.prob;
            if (newProb > dist[neighbor.node]) {
                dist[neighbor.node] = newProb;
                pq.push({ node: neighbor.node, prob: newProb });
            }
        }
    }

    return dist[end];
};