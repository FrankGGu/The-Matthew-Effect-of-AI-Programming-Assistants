var maxDistToClosest = function(seats) {
    let left = -1;
    let maxDistance = 0;
    const n = seats.length;

    for (let i = 0; i < n; i++) {
        if (seats[i] === 1) {
            if (left === -1) {
                maxDistance = Math.max(maxDistance, i);
            } else {
                maxDistance = Math.max(maxDistance, Math.floor((i - left) / 2));
            }
            left = i;
        }
    }

    maxDistance = Math.max(maxDistance, n - 1 - left);

    return maxDistance;
};