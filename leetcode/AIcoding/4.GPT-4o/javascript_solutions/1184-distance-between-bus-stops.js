var distanceBetweenBusStops = function(distance, start, destination) {
    if (start > destination) {
        [start, destination] = [destination, start];
    }
    const totalDistance = distance.reduce((a, b) => a + b, 0);
    const directDistance = distance.slice(start, destination).reduce((a, b) => a + b, 0);
    return Math.min(directDistance, totalDistance - directDistance);
};