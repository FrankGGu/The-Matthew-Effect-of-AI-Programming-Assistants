var minEdgeReversals = function(edges) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push([v, 0]);
        graph.get(v).push([u, 1]);
    }

    const bfs = (start) => {
        const queue = [[start, 0]];
        const visited = new Set([start]);
        let reversals = 0;

        while (queue.length) {
            const [node, rev] = queue.shift();
            reversals += rev;

            for (const [neighbor, edgeRev] of graph.get(node)) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    queue.push([neighbor, edgeRev]);
                }
            }
        }
        return visited.size === graph.size ? reversals : Infinity;
    };

    let minReversals = Infinity;
    for (const node of graph.keys()) {
        minReversals = Math.min(minReversals, bfs(node));
    }

    return minReversals;
};