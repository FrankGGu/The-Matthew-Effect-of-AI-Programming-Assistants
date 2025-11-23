var minimumTime = function(time, totalTrips) {
    let left = 1;
    let right = Math.min(...time) * totalTrips;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let trips = 0;
        for (const t of time) {
            trips += Math.floor(mid / t);
        }
        if (trips >= totalTrips) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};