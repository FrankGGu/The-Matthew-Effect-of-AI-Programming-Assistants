var shortestAlternatingPaths = function(n, redEdges, blueEdges) {
    const adj = Array(n).fill(null).map(() => ({ red: [], blue: [] }));
    for (const [u, v] of redEdges) {
        adj[u].red.push(v);
    }
    for (const [u, v] of blueEdges) {
        adj[u].blue.push(v);
    }

    const dist = Array(n).fill(-1);
    dist[0] = 0;

    const queue = [[0, null, 0]]; // [node, color, distance]
    const visited = new Set();
    visited.add('0_null');

    while (queue.length > 0) {
        const [node, color, distance] = queue.shift();

        if (color !== 'red') {
            for (const neighbor of adj[node].red) {
                const key = `${neighbor}_red`;
                if (!visited.has(key)) {
                    if (dist[neighbor] === -1) {
                        dist[neighbor] = distance + 1;
                    }
                    queue.push([neighbor, 'red', distance + 1]);
                    visited.add(key);
                }
            }
        }

        if (color !== 'blue') {
            for (const neighbor of adj[node].blue) {
                const key = `${neighbor}_blue`;
                if (!visited.has(key)) {
                    if (dist[neighbor] === -1) {
                        dist[neighbor] = distance + 1;
                    }
                    queue.push([neighbor, 'blue', distance + 1]);
                    visited.add(key);
                }
            }
        }
    }

    return dist;
};