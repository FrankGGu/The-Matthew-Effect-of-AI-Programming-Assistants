var maxDistToClosest = function(seats) {
    let left = -1;
    let maxDistance = 0;
    const n = seats.length;

    for (let right = 0; right < n; right++) {
        if (seats[right] === 1) {
            if (left === -1) {
                maxDistance = Math.max(maxDistance, right);
            } else {
                maxDistance = Math.max(maxDistance, Math.floor((right - left) / 2));
            }
            left = right;
        }
    }

    if (seats[n - 1] === 0) {
        maxDistance = Math.max(maxDistance, n - 1 - left);
    }

    return maxDistance;
};