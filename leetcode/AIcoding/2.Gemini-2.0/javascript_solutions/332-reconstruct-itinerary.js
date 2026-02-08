var findItinerary = function(tickets) {
    const graph = {};
    for (const [from, to] of tickets) {
        if (!graph[from]) {
            graph[from] = [];
        }
        graph[from].push(to);
    }

    for (const airport in graph) {
        graph[airport].sort();
    }

    const itinerary = [];
    const dfs = (airport) => {
        while (graph[airport] && graph[airport].length > 0) {
            const nextAirport = graph[airport].shift();
            dfs(nextAirport);
        }
        itinerary.unshift(airport);
    }

    dfs("JFK");
    return itinerary;
};