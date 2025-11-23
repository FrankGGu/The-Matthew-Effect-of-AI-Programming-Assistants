var minimumTime = function(time, totalTrips) {
    let left = 1, right = Math.min(...time) * totalTrips;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const trips = time.reduce((acc, t) => acc + Math.floor(mid / t), 0);

        if (trips >= totalTrips) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};