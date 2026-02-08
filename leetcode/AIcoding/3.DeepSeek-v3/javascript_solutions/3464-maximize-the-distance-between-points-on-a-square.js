var maxDistToClosest = function(seats) {
    let left = -1, maxDist = 0;
    const n = seats.length;

    for (let i = 0; i < n; i++) {
        if (seats[i] === 1) {
            if (left === -1) {
                maxDist = Math.max(maxDist, i);
            } else {
                maxDist = Math.max(maxDist, Math.floor((i - left) / 2));
            }
            left = i;
        }
    }

    if (seats[n - 1] === 0) {
        maxDist = Math.max(maxDist, n - 1 - left);
    }

    return maxDist;
};