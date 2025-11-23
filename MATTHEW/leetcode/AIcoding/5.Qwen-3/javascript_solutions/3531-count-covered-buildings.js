function countCoveredBuildings(buildings) {
    buildings.sort((a, b) => a[0] - b[0] || b[1] - a[1]);
    let count = 0;
    let maxHeight = 0;
    for (let i = 0; i < buildings.length; i++) {
        if (buildings[i][1] > maxHeight) {
            count++;
            maxHeight = buildings[i][1];
        }
    }
    return count;
}