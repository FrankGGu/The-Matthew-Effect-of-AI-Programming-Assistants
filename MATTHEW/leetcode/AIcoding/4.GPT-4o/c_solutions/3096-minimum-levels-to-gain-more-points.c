int minimumLevels(int* levels, int levelsSize, int target) {
    int count = 0;
    for (int i = 0; i < levelsSize; i++) {
        if (levels[i] < target) {
            count++;
        }
    }
    return count;
}