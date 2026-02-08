var numBusesToDestination = function(routes, source, target) {
    if (source === target) return 0;

    const stopToBuses = new Map();
    for (let bus = 0; bus < routes.length; bus++) {
        for (const stop of routes[bus]) {
            if (!stopToBuses.has(stop)) {
                stopToBuses.set(stop, []);
            }
            stopToBuses.get(stop).push(bus);
        }
    }

    if (!stopToBuses.has(source) || !stopToBuses.has(target)) return -1;

    const visitedBuses = new Set();
    const visitedStops = new Set();
    const queue = [[source, 0]];

    while (queue.length > 0) {
        const [currentStop, busesTaken] = queue.shift();
        if (currentStop === target) return busesTaken;

        for (const bus of stopToBuses.get(currentStop)) {
            if (visitedBuses.has(bus)) continue;
            visitedBuses.add(bus);

            for (const nextStop of routes[bus]) {
                if (visitedStops.has(nextStop)) continue;
                visitedStops.add(nextStop);
                queue.push([nextStop, busesTaken + 1]);
            }
        }
    }

    return -1;
};