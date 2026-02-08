var shortestAlternatingPaths = function(n, redEdges, blueEdges) {
    const graph = Array.from({ length: n }, () => ({ red: [], blue: [] }));

    for (const [u, v] of redEdges) {
        graph[u].red.push(v);
    }
    for (const [u, v] of blueEdges) {
        graph[u].blue.push(v);
    }

    const queue = [];
    const dist = Array.from({ length: n }, () => [Infinity, Infinity]);
    dist[0] = [0, 0];

    queue.push([0, 0, 0]); // node, distance, color (0 for red, 1 for blue)
    queue.push([0, 0, 1]);

    while (queue.length) {
        const [node, distance, color] = queue.shift();
        const nextColor = color === 0 ? 'blue' : 'red';

        for (const neighbor of graph[node][nextColor]) {
            if (dist[neighbor][nextColor === 'red' ? 0 : 1] === Infinity) {
                dist[neighbor][nextColor === 'red' ? 0 : 1] = distance + 1;
                queue.push([neighbor, distance + 1, nextColor === 'red' ? 0 : 1]);
            }
        }
    }

    return dist.map(d => Math.min(d[0], d[1]) === Infinity ? -1 : Math.min(d[0], d[1]));
};