var minTotalDistanceTraveled = function(robots, factories) {
    robots.sort((a, b) => a - b);
    factories.sort((a, b) => a - b);

    let totalDistance = 0;
    const numPairs = Math.min(robots.length, factories.length);

    for (let i = 0; i < numPairs; i++) {
        totalDistance += Math.abs(robots[i] - factories[i]);
    }

    return totalDistance;
};