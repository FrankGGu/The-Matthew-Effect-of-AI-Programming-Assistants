var numBusesToDestination = function(routes, S, T) {
    if (S === T) return 0;

    const graph = new Map();

    for (let i = 0; i < routes.length; i++) {
        for (let stop of routes[i]) {
            if (!graph.has(stop)) {
                graph.set(stop, []);
            }
            graph.get(stop).push(i);
        }
    }

    const queue = [];
    const visitedStops = new Set();
    const visitedBuses = new Set();

    queue.push(S);
    visitedStops.add(S);
    let buses = 0;

    while (queue.length > 0) {
        buses++;
        const size = queue.length;

        for (let i = 0; i < size; i++) {
            const stop = queue.shift();
            for (let bus of graph.get(stop) || []) {
                if (visitedBuses.has(bus)) continue;
                visitedBuses.add(bus);
                for (let nextStop of routes[bus]) {
                    if (nextStop === T) return buses;
                    if (!visitedStops.has(nextStop)) {
                        visitedStops.add(nextStop);
                        queue.push(nextStop);
                    }
                }
            }
        }
    }

    return -1;
};