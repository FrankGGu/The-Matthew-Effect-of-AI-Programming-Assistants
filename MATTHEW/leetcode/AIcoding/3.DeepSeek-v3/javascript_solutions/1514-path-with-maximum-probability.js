var maxProbability = function(n, edges, succProb, start, end) {
    const graph = new Array(n).fill().map(() => []);
    for (let i = 0; i < edges.length; i++) {
        const [u, v] = edges[i];
        const prob = succProb[i];
        graph[u].push([v, prob]);
        graph[v].push([u, prob]);
    }

    const probTo = new Array(n).fill(0);
    probTo[start] = 1;

    const queue = [[start, 1]];

    while (queue.length > 0) {
        const [currentNode, currentProb] = queue.shift();

        if (currentNode === end) continue;
        if (currentProb < probTo[currentNode]) continue;

        for (const [neighbor, edgeProb] of graph[currentNode]) {
            const nextProb = currentProb * edgeProb;
            if (nextProb > probTo[neighbor]) {
                probTo[neighbor] = nextProb;
                queue.push([neighbor, nextProb]);
            }
        }
    }

    return probTo[end];
};