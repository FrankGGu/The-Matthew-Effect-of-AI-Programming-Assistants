bool canMakeArithmeticProgression(int* arr, int arrSize) {
    if (arrSize < 2) return true;
    int minVal = arr[0], maxVal = arr[0];
    for (int i = 1; i < arrSize; i++) {
        if (arr[i] < minVal) minVal = arr[i];
        if (arr[i] > maxVal) maxVal = arr[i];
    }
    int diff = (maxVal - minVal) / (arrSize - 1);
    if (diff * (arrSize - 1) != (maxVal - minVal)) return false;

    bool* seen = (bool*)calloc(arrSize, sizeof(bool));
    for (int i = 0; i < arrSize; i++) {
        int index = (arr[i] - minVal) / diff;
        if (index < 0 || index >= arrSize || seen[index]) {
            free(seen);
            return false;
        }
        seen[index] = true;
    }
    free(seen);
    return true;
}