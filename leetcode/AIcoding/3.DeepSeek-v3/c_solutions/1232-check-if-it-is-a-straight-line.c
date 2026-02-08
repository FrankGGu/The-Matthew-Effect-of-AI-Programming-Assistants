bool checkStraightLine(int** coordinates, int coordinatesSize, int* coordinatesColSize) {
    if (coordinatesSize == 2) return true;

    int x0 = coordinates[0][0], y0 = coordinates[0][1];
    int x1 = coordinates[1][0], y1 = coordinates[1][1];

    for (int i = 2; i < coordinatesSize; i++) {
        int x = coordinates[i][0], y = coordinates[i][1];
        if ((y1 - y0) * (x - x0) != (y - y0) * (x1 - x0)) {
            return false;
        }
    }
    return true;
}