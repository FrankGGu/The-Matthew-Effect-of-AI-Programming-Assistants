function findBuilding(eastWestRoad, northSouthRoad) {
    const map = {};
    for (let i = 0; i < eastWestRoad.length; i++) {
        if (!map[eastWestRoad[i]]) {
            map[eastWestRoad[i]] = 1;
        } else {
            map[eastWestRoad[i]]++;
        }
    }
    for (let i = 0; i < northSouthRoad.length; i++) {
        if (map[northSouthRoad[i]] === 1) {
            return northSouthRoad[i];
        }
    }
    return -1;
}