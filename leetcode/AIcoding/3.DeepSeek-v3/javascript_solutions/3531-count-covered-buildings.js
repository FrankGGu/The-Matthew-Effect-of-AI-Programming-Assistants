var countCoveredBuildings = function(buildings) {
    if (buildings.length === 0) return 0;

    buildings.sort((a, b) => a[0] - b[0]);
    let count = 0;
    let prevEnd = buildings[0][1];
    let prevHeight = buildings[0][2];

    for (let i = 1; i < buildings.length; i++) {
        const [start, end, height] = buildings[i];
        if (start <= prevEnd && height <= prevHeight) {
            count++;
        } else {
            prevEnd = Math.max(prevEnd, end);
            prevHeight = Math.max(prevHeight, height);
        }
    }

    return count;
};