var closestMeetingNode = function(edges, node1, node2) {
    const n = edges.length;
    const graph = new Map();

    for (let i = 0; i < n; i++) {
        if (!graph.has(i)) graph.set(i, []);
        if (edges[i] !== -1) graph.get(i).push(edges[i]);
    }

    const bfs = (start) => {
        const dist = new Array(n).fill(Infinity);
        const queue = [start];
        dist[start] = 0;
        let index = 0;

        while (index < queue.length) {
            const node = queue[index++];
            for (const neighbor of graph.get(node)) {
                if (dist[neighbor] === Infinity) {
                    dist[neighbor] = dist[node] + 1;
                    queue.push(neighbor);
                }
            }
        }
        return dist;
    };

    const dist1 = bfs(node1);
    const dist2 = bfs(node2);

    let minDist = Infinity;
    let resultNode = -1;

    for (let i = 0; i < n; i++) {
        const maxDist = Math.max(dist1[i], dist2[i]);
        if (maxDist < minDist) {
            minDist = maxDist;
            resultNode = i;
        }
    }

    return resultNode;
};