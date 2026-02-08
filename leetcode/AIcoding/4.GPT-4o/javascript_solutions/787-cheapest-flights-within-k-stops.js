var findCheapestPrice = function(n, flights, src, dst, K) {
    const dist = new Array(n).fill(Infinity);
    dist[src] = 0;
    for (let i = 0; i <= K; i++) {
        const tempDist = [...dist];
        for (const [u, v, w] of flights) {
            if (dist[u] !== Infinity) {
                tempDist[v] = Math.min(tempDist[v], dist[u] + w);
            }
        }
        dist = tempDist;
    }
    return dist[dst] === Infinity ? -1 : dist[dst];
};