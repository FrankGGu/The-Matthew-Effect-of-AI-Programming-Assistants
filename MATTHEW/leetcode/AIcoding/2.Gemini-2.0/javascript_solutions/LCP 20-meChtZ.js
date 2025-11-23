var numBusesToDestination = function(routes, source, target) {
    if (source === target) return 0;

    const adj = new Map();
    for (let i = 0; i < routes.length; i++) {
        for (const stop of routes[i]) {
            if (!adj.has(stop)) {
                adj.set(stop, []);
            }
            adj.get(stop).push(i);
        }
    }

    const queue = [[source, 0]];
    const visitedStops = new Set();
    const visitedRoutes = new Set();
    visitedStops.add(source);

    while (queue.length > 0) {
        const [stop, buses] = queue.shift();

        if (stop === target) {
            return buses;
        }

        if (!adj.has(stop)) continue;

        for (const routeIndex of adj.get(stop)) {
            if (visitedRoutes.has(routeIndex)) continue;
            visitedRoutes.add(routeIndex);

            for (const nextStop of routes[routeIndex]) {
                if (!visitedStops.has(nextStop)) {
                    queue.push([nextStop, buses + 1]);
                    visitedStops.add(nextStop);
                }
            }
        }
    }

    return -1;
};