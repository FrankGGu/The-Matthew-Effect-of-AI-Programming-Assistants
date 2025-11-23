var numBusesToReachTarget = function(routes, source, target) {
    if (source === target) {
        return 0;
    }

    const stopToRoutesMap = new Map();
    for (let i = 0; i < routes.length; i++) {
        for (const stop of routes[i]) {
            if (!stopToRoutesMap.has(stop)) {
                stopToRoutesMap.set(stop, new Set());
            }
            stopToRoutesMap.get(stop).add(i);
        }
    }

    if (!stopToRoutesMap.has(source)) {
        return -1;
    }

    const queue = [];
    const visitedRoutes = new Set();

    for (const routeIndex of stopToRoutesMap.get(source)) {
        queue.push([routeIndex, 1]);
        visitedRoutes.add(routeIndex);
    }

    let head = 0;
    while (head < queue.length) {
        const [currentRouteIndex, busesTaken] = queue[head++];

        for (const stop of routes[currentRouteIndex]) {
            if (stop === target) {
                return busesTaken;
            }
        }

        for (const stop of routes[currentRouteIndex]) {
            if (stopToRoutesMap.has(stop)) {
                for (const nextRouteIndex of stopToRoutesMap.get(stop)) {
                    if (!visitedRoutes.has(nextRouteIndex)) {
                        visitedRoutes.add(nextRouteIndex);
                        queue.push([nextRouteIndex, busesTaken + 1]);
                    }
                }
            }
        }
    }

    return -1;
};