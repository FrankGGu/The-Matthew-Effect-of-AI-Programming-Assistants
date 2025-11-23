var findItinerary = function(tickets) {
    const graph = new Map();

    for (const [from, to] of tickets) {
        if (!graph.has(from)) {
            graph.set(from, []);
        }
        graph.get(from).push(to);
    }

    for (const destinations of graph.values()) {
        destinations.sort();
    }

    const result = [];

    function dfs(airport) {
        const destinations = graph.get(airport);

        while (destinations && destinations.length > 0) {
            const nextAirport = destinations.shift();
            dfs(nextAirport);
        }
        result.push(airport);
    }

    dfs("JFK");

    return result.reverse();
};