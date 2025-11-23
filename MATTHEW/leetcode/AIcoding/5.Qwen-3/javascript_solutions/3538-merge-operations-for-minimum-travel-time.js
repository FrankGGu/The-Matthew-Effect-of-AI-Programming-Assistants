function minTravelTime(n, roads) {
    const graph = new Map();
    for (let [u, v, t] of roads) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push([v, t]);
        graph.get(v).push([u, t]);
    }

    const dist = new Array(n + 1).fill(Infinity);
    dist[1] = 0;
    const pq = [[0, 1]];
    const visited = new Set();

    while (pq.length > 0) {
        const [d, u] = pq.shift();
        if (visited.has(u)) continue;
        visited.add(u);
        for (const [v, t] of graph.get(u) || []) {
            if (dist[v] > d + t) {
                dist[v] = d + t;
                pq.push([dist[v], v]);
            }
        }
    }

    return dist[n];
}