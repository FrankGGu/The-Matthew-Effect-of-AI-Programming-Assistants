var distanceBetweenBusStops = function(distance, start, end) {
    if (start === end) return 0;
    let total = 0;
    for (let d of distance) total += d;
    let min = Math.min(start, end);
    let max = Math.max(start, end);
    let sum = 0;
    for (let i = min; i < max; i++) sum += distance[i];
    return Math.min(sum, total - sum);
};