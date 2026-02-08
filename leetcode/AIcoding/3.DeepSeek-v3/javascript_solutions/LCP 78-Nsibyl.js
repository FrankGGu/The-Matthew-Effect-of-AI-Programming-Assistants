var fortressShooting = function(walls) {
    walls.sort((a, b) => a[0] - b[0]);
    let maxGap = 0;
    for (let i = 1; i < walls.length; i++) {
        const gap = walls[i][0] - walls[i - 1][1];
        if (gap > maxGap) {
            maxGap = gap;
        }
    }
    return maxGap;
};