var modifiedGraphEdges = function(n, edges, source, destination, target) {
    const originalEdges = edges.map(edge => [...edge]);
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    function dijkstra(start, skipNegative) {
        const dist = Array(n).fill(Infinity);
        dist[start] = 0;
        const heap = [[0, start]];
        while (heap.length) {
            const [d, u] = heap.shift();
            if (d > dist[u]) continue;
            for (const [v, w] of adj[u]) {
                if (w === -1) {
                    if (skipNegative) continue;
                    else continue;
                }
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    heap.push([dist[v], v]);
                    heap.sort((a, b) => a[0] - b[0]);
                }
            }
        }
        return dist;
    }

    const distSource = dijkstra(source, true);
    if (distSource[destination] < target) {
        return [];
    }
    if (distSource[destination] === target) {
        return edges.map(([u, v, w]) => [u, v, w === -1 ? 1 : w]);
    }

    for (let i = 0; i < edges.length; i++) {
        const [u, v, w] = edges[i];
        if (w === -1) {
            edges[i][2] = 1;
            adj[u] = adj[u].map(([node, weight]) => node === v ? [node, 1] : [node, weight]);
            adj[v] = adj[v].map(([node, weight]) => node === u ? [node, 1] : [node, weight]);
            const dist = dijkstra(source, true);
            if (dist[destination] <= target) {
                edges[i][2] += target - dist[destination];
                for (let j = i + 1; j < edges.length; j++) {
                    if (edges[j][2] === -1) {
                        edges[j][2] = 1;
                    }
                }
                return edges;
            }
        }
    }

    return [];
};