var minimumTime = function(time, totalTrips) {
    let left = 1n;
    let right = BigInt(Math.max(...time)) * BigInt(totalTrips);
    let ans = right;

    while (left <= right) {
        let mid = left + (right - left) / 2n;
        let tripsCompleted = 0n;

        for (let t of time) {
            tripsCompleted += mid / BigInt(t);
        }

        if (tripsCompleted >= BigInt(totalTrips)) {
            ans = mid;
            right = mid - 1n;
        } else {
            left = mid + 1n;
        }
    }

    return Number(ans);
};