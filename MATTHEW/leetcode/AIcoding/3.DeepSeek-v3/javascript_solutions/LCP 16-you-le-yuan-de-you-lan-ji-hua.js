var maxWeight = function(edges, plans) {
    const n = edges.length + 1;
    const graph = Array.from({ length: n }, () => []);
    const weight = Array(n).fill(0);

    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    for (const [u, t] of plans) {
        const queue = [[u, 0]];
        const visited = new Set([u]);

        while (queue.length > 0) {
            const [node, time] = queue.shift();
            if (time > t) continue;

            weight[node] += t - time;

            for (const [neighbor, w] of graph[node]) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    queue.push([neighbor, time + w]);
                }
            }
        }
    }

    return Math.max(...weight);
};