function findCheapestPrice(n, flights, src, dst, k) {
    const graph = new Array(n).fill(0).map(() => []);
    for (const [from, to, price] of flights) {
        graph[from].push([to, price]);
    }

    const dist = new Array(n).fill(Infinity);
    dist[src] = 0;

    for (let i = 0; i <= k; i++) {
        const tempDist = [...dist];
        for (const [from, tos] of graph.entries()) {
            for (const [to, price] of tos) {
                if (dist[from] + price < tempDist[to]) {
                    tempDist[to] = dist[from] + price;
                }
            }
        }
        dist.splice(0, n, ...tempDist);
    }

    return dist[dst] === Infinity ? -1 : dist[dst];
}