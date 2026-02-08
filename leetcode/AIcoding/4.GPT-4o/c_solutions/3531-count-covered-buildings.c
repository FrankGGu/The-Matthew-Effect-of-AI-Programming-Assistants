int countCoveredBuildings(int** buildings, int buildingsSize, int* buildingsColSize) {
    int count = 0;
    int maxEnd = 0;

    for (int i = 0; i < buildingsSize; i++) {
        if (buildings[i][1] > maxEnd) {
            count += buildings[i][1] - buildings[i][0];
            maxEnd = buildings[i][1];
        } else if (buildings[i][0] < maxEnd) {
            count += buildings[i][1] - maxEnd;
            maxEnd = buildings[i][1];
        }
    }

    return count;
}