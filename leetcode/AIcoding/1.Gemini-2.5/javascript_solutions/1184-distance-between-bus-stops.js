var distanceBetweenBusStops = function(distance, start, destination) {
    let totalDistance = 0;
    for (let i = 0; i < distance.length; i++) {
        totalDistance += distance[i];
    }

    let clockwiseDistance = 0;
    let current = start;
    while (current !== destination) {
        clockwiseDistance += distance[current];
        current = (current + 1) % distance.length;
    }

    let counterClockwiseDistance = totalDistance - clockwiseDistance;

    return Math.min(clockwiseDistance, counterClockwiseDistance);
};