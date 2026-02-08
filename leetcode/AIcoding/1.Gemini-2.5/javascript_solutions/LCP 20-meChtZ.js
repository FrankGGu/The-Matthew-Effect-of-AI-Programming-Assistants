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

    if (!stopToRoutesMap.has(source) || !stopToRoutesMap.has(target)) {
        return -1;
    }

    const queue = [];
    const visitedRoutes = new Set();
    let busesTaken = 0;

    const initialRoutes = stopToRoutesMap.get(source);

    for (const routeIdx of initialRoutes) {
        queue.push(routeIdx);
        visitedRoutes.add(routeIdx);
    }

    while (queue.length > 0) {
        busesTaken++;
        const levelSize = queue.length;

        for (let i = 0; i < levelSize; i++) {
            const currentRouteIdx = queue.shift();

            for (const stop of routes[currentRouteIdx]) {
                if (stop === target) {
                    return busesTaken;
                }

                const connectingRoutes = stopToRoutesMap.get(stop);
                if (connectingRoutes) {
                    for (const nextRouteIdx of connectingRoutes) {
                        if (!visitedRoutes.has(nextRouteIdx)) {
                            visitedRoutes.add(nextRouteIdx);
                            queue.push(nextRouteIdx);
                        }
                    }
                }
            }
        }
    }

    return -1;
};