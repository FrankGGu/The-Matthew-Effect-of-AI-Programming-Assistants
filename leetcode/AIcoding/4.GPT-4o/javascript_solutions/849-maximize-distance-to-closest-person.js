var maxDistToClosest = function(seats) {
    let maxDistance = 0;
    let lastOccupied = -1;
    let n = seats.length;

    for (let i = 0; i < n; i++) {
        if (seats[i] === 1) {
            if (lastOccupied === -1) {
                maxDistance = i; // Distance from the start
            } else {
                maxDistance = Math.max(maxDistance, Math.floor((i - lastOccupied) / 2));
            }
            lastOccupied = i;
        }
    }

    // Check the distance from the last occupied seat to the end
    if (lastOccupied !== -1) {
        maxDistance = Math.max(maxDistance, n - 1 - lastOccupied);
    }

    return maxDistance;
};