int getMaxDefense(int* walls, int wallsSize) {
    int maxDefense = 0;

    for (int i = 0; i < wallsSize; i++) {
        for (int j = i + 1; j < wallsSize; j++) {
            int minHeight = walls[i] < walls[j] ? walls[i] : walls[j];
            int width = j - i;
            maxDefense = maxDefense > minHeight * width ? maxDefense : minHeight * width;
        }
    }

    return maxDefense;
}