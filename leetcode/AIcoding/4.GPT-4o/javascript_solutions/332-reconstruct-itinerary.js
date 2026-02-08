var findItinerary = function(tickets) {
    const graph = new Map();
    for (const [from, to] of tickets) {
        if (!graph.has(from)) graph.set(from, []);
        graph.get(from).push(to);
    }
    for (const key of graph.keys()) {
        graph.get(key).sort();
    }

    const result = [];
    const dfs = (airport) => {
        const destinations = graph.get(airport);
        while (destinations && destinations.length) {
            dfs(destinations.shift());
        }
        result.unshift(airport);
    };

    dfs("JFK");
    return result;
};