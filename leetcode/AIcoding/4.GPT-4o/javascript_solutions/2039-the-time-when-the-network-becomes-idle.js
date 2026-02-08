var networkBecomesIdle = function(edges, patience) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const bfs = (start) => {
        const queue = [start];
        const distance = new Map();
        distance.set(start, 0);

        while (queue.length) {
            const node = queue.shift();
            const dist = distance.get(node);
            for (const neighbor of graph.get(node)) {
                if (!distance.has(neighbor)) {
                    distance.set(neighbor, dist + 1);
                    queue.push(neighbor);
                }
            }
        }
        return distance;
    };

    const distances = bfs(0);
    let maxIdleTime = 0;

    for (const [i, d] of distances.entries()) {
        const totalTime = d * 2;
        const waitTime = Math.ceil(totalTime / patience[i]) * patience[i];
        maxIdleTime = Math.max(maxIdleTime, waitTime + d);
    }

    return maxIdleTime;
};