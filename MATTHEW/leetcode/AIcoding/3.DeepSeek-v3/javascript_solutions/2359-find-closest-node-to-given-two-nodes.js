var closestMeetingNode = function(edges, node1, node2) {
    const n = edges.length;
    const dist1 = new Array(n).fill(-1);
    const dist2 = new Array(n).fill(-1);

    const bfs = (start, dist) => {
        const queue = [];
        queue.push(start);
        dist[start] = 0;
        while (queue.length > 0) {
            const current = queue.shift();
            const neighbor = edges[current];
            if (neighbor !== -1 && dist[neighbor] === -1) {
                dist[neighbor] = dist[current] + 1;
                queue.push(neighbor);
            }
        }
    };

    bfs(node1, dist1);
    bfs(node2, dist2);

    let minDist = Infinity;
    let result = -1;

    for (let i = 0; i < n; i++) {
        if (dist1[i] !== -1 && dist2[i] !== -1) {
            const currentMax = Math.max(dist1[i], dist2[i]);
            if (currentMax < minDist) {
                minDist = currentMax;
                result = i;
            }
        }
    }

    return result;
};