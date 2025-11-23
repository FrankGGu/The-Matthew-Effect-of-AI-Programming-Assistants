var maxDistToClosest = function(seats) {
    let maxDist = 0;
    let lastPersonIndex = -1;
    const n = seats.length;

    for (let i = 0; i < n; i++) {
        if (seats[i] === 1) {
            if (lastPersonIndex === -1) {
                maxDist = Math.max(maxDist, i);
            } else {
                maxDist = Math.max(maxDist, Math.floor((i - lastPersonIndex) / 2));
            }
            lastPersonIndex = i;
        }
    }

    maxDist = Math.max(maxDist, n - 1 - lastPersonIndex);

    return maxDist;
};