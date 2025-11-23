var findCheapestPrice = function(n, flights, src, dst, k) {
    let dist = new Array(n).fill(Infinity);
    dist[src] = 0;

    for (let i = 0; i <= k; i++) {
        let tempDist = [...dist];

        for (let [u, v, price] of flights) {
            if (dist[u] !== Infinity) {
                tempDist[v] = Math.min(tempDist[v], dist[u] + price);
            }
        }
        dist = tempDist;
    }

    return dist[dst] === Infinity ? -1 : dist[dst];
};