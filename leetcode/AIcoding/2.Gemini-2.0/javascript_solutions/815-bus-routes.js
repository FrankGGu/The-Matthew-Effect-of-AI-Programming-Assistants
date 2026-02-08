var numBusesToDestination = function(routes, source, target) {
    if (source === target) return 0;

    const stopToRoutes = new Map();
    for (let i = 0; i < routes.length; i++) {
        for (const stop of routes[i]) {
            if (!stopToRoutes.has(stop)) {
                stopToRoutes.set(stop, []);
            }
            stopToRoutes.get(stop).push(i);
        }
    }

    if (!stopToRoutes.has(source) || !stopToRoutes.has(target)) return -1;

    const queue = [source];
    const visitedStops = new Set();
    const visitedRoutes = new Set();
    let buses = 0;

    while (queue.length > 0) {
        buses++;
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const stop = queue.shift();
            if (stop === target) return buses - 1;

            for (const routeIndex of stopToRoutes.get(stop)) {
                if (visitedRoutes.has(routeIndex)) continue;
                visitedRoutes.add(routeIndex);

                for (const nextStop of routes[routeIndex]) {
                    if (visitedStops.has(nextStop)) continue;
                    visitedStops.add(nextStop);
                    queue.push(nextStop);
                }
            }
        }
    }

    return -1;
};