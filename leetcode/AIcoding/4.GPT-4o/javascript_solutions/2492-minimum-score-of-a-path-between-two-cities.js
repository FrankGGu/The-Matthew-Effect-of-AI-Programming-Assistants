var minScore = function(n, roads) {
    const graph = new Map();
    for (const [u, v, w] of roads) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push([v, w]);
        graph.get(v).push([u, w]);
    }

    const visited = new Set();
    const queue = [1];
    let minScore = Infinity;

    while (queue.length) {
        const city = queue.pop();
        visited.add(city);
        for (const [neighbour, score] of graph.get(city)) {
            if (!visited.has(neighbour)) {
                queue.push(neighbour);
                minScore = Math.min(minScore, score);
            }
        }
    }

    return minScore === Infinity ? 0 : minScore;
};