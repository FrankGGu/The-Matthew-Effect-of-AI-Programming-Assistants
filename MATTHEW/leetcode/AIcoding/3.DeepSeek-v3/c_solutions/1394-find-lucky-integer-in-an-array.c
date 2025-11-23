int findLucky(int* arr, int arrSize) {
    int freq[501] = {0};
    for (int i = 0; i < arrSize; i++) {
        freq[arr[i]]++;
    }
    int maxLucky = -1;
    for (int i = 1; i <= 500; i++) {
        if (freq[i] == i) {
            if (i > maxLucky) {
                maxLucky = i;
            }
        }
    }
    return maxLucky;
}