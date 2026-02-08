var findTheCity = function(n, edges, distanceThreshold) {
    const graph = Array.from({length: n}, () => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const dijkstra = (src) => {
        const dist = Array(n).fill(Infinity);
        dist[src] = 0;
        const pq = [[0, src]];

        while (pq.length) {
            const [d, node] = pq.shift();
            if (d > dist[node]) continue;

            for (const [neighbor, weight] of graph[node]) {
                const newDist = d + weight;
                if (newDist < dist[neighbor]) {
                    dist[neighbor] = newDist;
                    pq.push([newDist, neighbor]);
                }
            }
        }
        return dist;
    };

    let resultCity = -1;
    let minNeighbors = Infinity;

    for (let i = 0; i < n; i++) {
        const distances = dijkstra(i);
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (i !== j && distances[j] <= distanceThreshold) {
                count++;
            }
        }
        if (count < minNeighbors || (count === minNeighbors && i > resultCity)) {
            minNeighbors = count;
            resultCity = i;
        }
    }

    return resultCity;
};