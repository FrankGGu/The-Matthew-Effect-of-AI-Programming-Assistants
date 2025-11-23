function minCost(n, edges, start, end, k, fee) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const dist = Array.from({ length: n }, () => Array(k + 1).fill(Infinity));
    const pq = [[0, start, 0]];
    dist[start][0] = 0;

    while (pq.length > 0) {
        const [cost, node, steps] = pq.shift();
        if (node === end) return cost;
        if (steps > k) continue;
        for (const [nextNode, weight] of graph[node]) {
            const newCost = cost + weight + fee;
            if (dist[nextNode][steps + 1] > newCost) {
                dist[nextNode][steps + 1] = newCost;
                pq.push([newCost, nextNode, steps + 1]);
            }
        }
    }

    return -1;
}