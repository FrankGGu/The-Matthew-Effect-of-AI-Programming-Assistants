var findItinerary = function(tickets) {
    const graph = {};
    for (const [from, to] of tickets) {
        if (!graph[from]) graph[from] = [];
        graph[from].push(to);
    }
    for (const from in graph) {
        graph[from].sort().reverse();
    }
    const itinerary = [];
    const dfs = (node) => {
        const destinations = graph[node];
        while (destinations && destinations.length > 0) {
            dfs(destinations.pop());
        }
        itinerary.push(node);
    };
    dfs('JFK');
    return itinerary.reverse();
};