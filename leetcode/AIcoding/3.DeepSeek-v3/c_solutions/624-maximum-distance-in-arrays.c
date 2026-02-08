int maxDistance(int** arrays, int arraysSize, int* arraysColSize) {
    int min_val = arrays[0][0];
    int max_val = arrays[0][arraysColSize[0] - 1];
    int result = 0;

    for (int i = 1; i < arraysSize; i++) {
        int current_min = arrays[i][0];
        int current_max = arrays[i][arraysColSize[i] - 1];

        result = fmax(result, fmax(fabs(current_max - min_val), fabs(max_val - current_min)));

        min_val = fmin(min_val, current_min);
        max_val = fmax(max_val, current_max);
    }

    return result;
}