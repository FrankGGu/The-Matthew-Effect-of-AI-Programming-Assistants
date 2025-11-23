var minCost = function(maxTime, edges, passingFees) {
    const n = passingFees.length;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, time] of edges) {
        adj[u].push([v, time]);
        adj[v].push([u, time]);
    }

    const dist = Array(n).fill(Infinity);
    const time = Array(n).fill(Infinity);

    dist[0] = passingFees[0];
    time[0] = 0;

    const pq = [[passingFees[0], 0, 0]]; // [cost, node, time]

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [cost, u, t] = pq.shift();

        if (cost > dist[u] || t > time[u]) continue;

        if (u === n - 1) return cost;

        for (const [v, travelTime] of adj[u]) {
            if (t + travelTime <= maxTime) {
                const newCost = cost + passingFees[v];
                const newTime = t + travelTime;

                if (newCost < dist[v] || newTime < time[v]) {
                    dist[v] = newCost;
                    time[v] = newTime;
                    pq.push([newCost, v, newTime]);
                }
            }
        }
    }

    return -1;
};