var countCoveredBuildings = function(buildings) {
    buildings.sort((a, b) => a[0] - b[0]);
    let covered = 0;
    let end = -1;
    for (const [start, duration] of buildings) {
        if (start > end) {
            covered++;
            end = start + duration;
        } else {
            end = Math.max(end, start + duration);
        }
    }
    return covered;
};