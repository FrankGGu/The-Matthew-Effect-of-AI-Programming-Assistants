function findItinerary(tickets) {
    const graph = new Map();
    for (const [source, dest] of tickets) {
        if (!graph.has(source)) {
            graph.set(source, []);
        }
        graph.get(source).push(dest);
    }

    for (const key of graph.keys()) {
        graph.get(key).sort();
    }

    const result = [];

    function dfs(node) {
        const neighbors = graph.get(node) || [];
        while (neighbors.length > 0) {
            const next = neighbors.shift();
            dfs(next);
        }
        result.unshift(node);
    }

    dfs('JFK');

    return result;
}