var distanceBetweenBusStops = function(distance, start, destination) {
    let n = distance.length;
    let clockwise = 0;
    let total = 0;

    for (let i = 0; i < n; i++) {
        total += distance[i];
    }

    let s = Math.min(start, destination);
    let d = Math.max(start, destination);

    for (let i = s; i < d; i++) {
        clockwise += distance[i];
    }

    return Math.min(clockwise, total - clockwise);
};