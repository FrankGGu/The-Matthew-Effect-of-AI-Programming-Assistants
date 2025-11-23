var maxDistToClosest = function(seats) {
    let n = seats.length;
    let prev = -1;
    let maxDist = 0;
    for (let i = 0; i < n; i++) {
        if (seats[i] === 1) {
            if (prev === -1) {
                maxDist = i;
            } else {
                maxDist = Math.max(maxDist, Math.floor((i - prev) / 2));
            }
            prev = i;
        }
    }
    if (seats[n - 1] === 0) {
        maxDist = Math.max(maxDist, n - 1 - prev);
    }
    return maxDist;
};