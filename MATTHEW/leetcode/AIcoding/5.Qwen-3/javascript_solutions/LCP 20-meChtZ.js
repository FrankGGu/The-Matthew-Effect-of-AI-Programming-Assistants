function numBusesToDestination(routes, source, target) {
    if (source === target) return 0;

    const map = new Map();
    for (let i = 0; i < routes.length; i++) {
        for (const stop of routes[i]) {
            if (!map.has(stop)) {
                map.set(stop, []);
            }
            map.get(stop).push(i);
        }
    }

    const visitedStops = new Set([source]);
    const visitedRoutes = new Set();
    const queue = [];

    for (const route of map.get(source)) {
        queue.push({ route, stops: 1 });
        visitedRoutes.add(route);
    }

    while (queue.length > 0) {
        const { route, stops } = queue.shift();
        for (const stop of routes[route]) {
            if (stop === target) return stops;
            if (visitedStops.has(stop)) continue;
            visitedStops.add(stop);
            for (const nextRoute of map.get(stop)) {
                if (!visitedRoutes.has(nextRoute)) {
                    visitedRoutes.add(nextRoute);
                    queue.push({ route: nextRoute, stops: stops + 1 });
                }
            }
        }
    }

    return -1;
}