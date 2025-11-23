int findLucky(int* arr, int arrSize) {
    int count[501] = {0};
    for (int i = 0; i < arrSize; i++) {
        count[arr[i]]++;
    }
    for (int i = 500; i >= 1; i--) {
        if (count[i] == i) {
            return i;
        }
    }
    return -1;
}