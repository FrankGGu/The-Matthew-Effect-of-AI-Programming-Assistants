bool checkStraightLine(int** coordinates, int coordinatesSize, int* coordinatesColSize) {
    if (coordinatesSize <= 2) {
        return true;
    }

    int x0 = coordinates[0][0];
    int y0 = coordinates[0][1];
    int x1 = coordinates[1][0];
    int y1 = coordinates[1][1];

    int dx = x1 - x0;
    int dy = y1 - y0;

    for (int i = 2; i < coordinatesSize; i++) {
        int xi = coordinates[i][0];
        int yi = coordinates[i][1];

        // Check if (xi - x0) * dy == (yi - y0) * dx
        // This is equivalent to checking if the slope between (x0, y0) and (xi, yi)
        // is the same as the slope between (x0, y0) and (x1, y1).
        // To avoid division by zero, we use cross-multiplication.
        if ((long long)(xi - x0) * dy != (long long)(yi - y0) * dx) {
            return false;
        }
    }

    return true;
}