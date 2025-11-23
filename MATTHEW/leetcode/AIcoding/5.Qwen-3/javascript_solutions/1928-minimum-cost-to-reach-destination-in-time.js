function minCostToReachDestination(n, highways, k) {
    const graph = new Array(n).fill(0).map(() => []);
    for (const [u, v, cost, time] of highways) {
        graph[u].push([v, cost, time]);
        graph[v].push([u, cost, time]);
    }

    const dist = new Array(n).fill(Infinity);
    const timeTo = new Array(n).fill(Infinity);
    dist[0] = 0;
    timeTo[0] = 0;

    const pq = [[0, 0, 0]]; // [cost, time, node]

    while (pq.length > 0) {
        const [cost, time, u] = pq.shift();

        if (u === n - 1) break;

        if (time > timeTo[u]) continue;

        for (const [v, c, t] of graph[u]) {
            const newTime = time + t;
            const newCost = cost + c;
            if (newTime < timeTo[v]) {
                timeTo[v] = newTime;
                dist[v] = newCost;
                pq.push([newCost, newTime, v]);
            } else if (newTime === timeTo[v] && newCost < dist[v]) {
                dist[v] = newCost;
                pq.push([newCost, newTime, v]);
            }
        }
    }

    return dist[n - 1] === Infinity ? -1 : dist[n - 1];
}