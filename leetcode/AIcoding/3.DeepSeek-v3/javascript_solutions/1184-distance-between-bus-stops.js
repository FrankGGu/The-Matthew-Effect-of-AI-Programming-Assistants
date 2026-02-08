var distanceBetweenBusStops = function(distance, start, destination) {
    let total = 0;
    let clockwise = 0;
    let s = Math.min(start, destination);
    let d = Math.max(start, destination);

    for (let i = 0; i < distance.length; i++) {
        if (i >= s && i < d) {
            clockwise += distance[i];
        }
        total += distance[i];
    }

    return Math.min(clockwise, total - clockwise);
};