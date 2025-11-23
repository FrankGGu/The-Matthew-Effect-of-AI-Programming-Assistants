int minimumOperations(int *colors, int colorsSize) {
    int count[3] = {0}; 
    for (int i = 0; i < colorsSize; i++) {
        count[colors[i] - 1]++;
    }

    int maxCount = 0;
    for (int i = 0; i < 3; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
        }
    }

    return colorsSize - maxCount;
}