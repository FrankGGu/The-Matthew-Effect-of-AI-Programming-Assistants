int maxDistance(int** arrays, int arraysSize, int* arraysColSize) {
    int min1 = arrays[0][0], max1 = arrays[0][0];
    int maxDistance = 0;

    for (int i = 0; i < arraysSize; i++) {
        int min2 = arrays[i][0], max2 = arrays[i][0];
        for (int j = 1; j < arraysColSize[i]; j++) {
            if (arrays[i][j] < min2) min2 = arrays[i][j];
            if (arrays[i][j] > max2) max2 = arrays[i][j];
        }
        if (i > 0) {
            maxDistance = fmax(maxDistance, max2 - min1);
            maxDistance = fmax(maxDistance, max1 - min2);
        }
        min1 = fmin(min1, min2);
        max1 = fmax(max1, max2);
    }

    return maxDistance;
}