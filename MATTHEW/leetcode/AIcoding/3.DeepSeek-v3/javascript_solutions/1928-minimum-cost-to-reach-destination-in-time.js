var minCost = function(maxTime, edges, passingFees) {
    const n = passingFees.length;
    const graph = new Array(n).fill().map(() => []);
    for (const [u, v, t] of edges) {
        graph[u].push([v, t]);
        graph[v].push([u, t]);
    }

    const dp = new Array(n).fill().map(() => new Array(maxTime + 1).fill(Infinity));
    dp[0][0] = passingFees[0];

    const heap = new MinPriorityQueue({ priority: (x) => x.cost });
    heap.enqueue({ node: 0, time: 0, cost: passingFees[0] });

    while (!heap.isEmpty()) {
        const { node, time, cost } = heap.dequeue().element;
        if (node === n - 1) return cost;
        if (cost > dp[node][time]) continue;

        for (const [neighbor, t] of graph[node]) {
            const newTime = time + t;
            if (newTime > maxTime) continue;
            const newCost = cost + passingFees[neighbor];
            if (newCost < dp[neighbor][newTime]) {
                dp[neighbor][newTime] = newCost;
                heap.enqueue({ node: neighbor, time: newTime, cost: newCost });
            }
        }
    }

    return -1;
};