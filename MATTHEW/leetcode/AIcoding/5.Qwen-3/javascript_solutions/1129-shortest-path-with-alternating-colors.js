function shortestAlternatingPath(n, redEdges, blueEdges) {
    const graph = new Array(n).fill(0).map(() => new Array(2).fill(0).map(() => []));
    for (const [u, v] of redEdges) {
        graph[u][0].push(v);
    }
    for (const [u, v] of blueEdges) {
        graph[u][1].push(v);
    }

    const dist = new Array(n).fill(0).map(() => [-1, -1]);
    const queue = [[0, 0], [0, 1]];

    dist[0][0] = 0;
    dist[0][1] = 0;

    while (queue.length > 0) {
        const [node, color] = queue.shift();
        const nextColor = 1 - color;

        for (const neighbor of graph[node][color]) {
            if (dist[neighbor][nextColor] === -1) {
                dist[neighbor][nextColor] = dist[node][color] + 1;
                queue.push([neighbor, nextColor]);
            }
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (dist[i][0] === -1 || dist[i][1] === -1) {
            result.push(Math.min(dist[i][0], dist[i][1]));
        } else {
            result.push(Math.min(dist[i][0], dist[i][1]));
        }
    }

    return result;
}