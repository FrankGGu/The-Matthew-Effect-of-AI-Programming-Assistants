int countAdjacentPairs(int* colors, int colorsSize) {
    int count = 0;
    for (int i = 1; i < colorsSize; i++) {
        if (colors[i] == colors[i - 1]) {
            count++;
        }
    }
    return count;
}