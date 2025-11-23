var closestMeetingNode = function(n, edges, node1, node2) {
    const dist1 = new Array(n).fill(Infinity);
    const dist2 = new Array(n).fill(Infinity);

    const bfs = (startNode, dist) => {
        const queue = [startNode];
        dist[startNode] = 0;

        while (queue.length > 0) {
            const node = queue.shift();
            const neighbor = edges[node];

            if (neighbor !== -1 && dist[neighbor] === Infinity) {
                dist[neighbor] = dist[node] + 1;
                queue.push(neighbor);
            }
        }
    };

    bfs(node1, dist1);
    bfs(node2, dist2);

    let minDist = Infinity;
    let closestNode = -1;

    for (let i = 0; i < n; i++) {
        const maxDist = Math.max(dist1[i], dist2[i]);

        if (maxDist < minDist) {
            minDist = maxDist;
            closestNode = i;
        }
    }

    return closestNode;
};