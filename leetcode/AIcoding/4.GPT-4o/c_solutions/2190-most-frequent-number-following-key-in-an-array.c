int mostFrequent(int* arr, int arrSize, int key) {
    int freq[1001] = {0};
    for (int i = 0; i < arrSize - 1; i++) {
        if (arr[i] == key) {
            freq[arr[i + 1]]++;
        }
    }
    int maxFreq = 0, result = -1;
    for (int i = 0; i < 1001; i++) {
        if (freq[i] > maxFreq) {
            maxFreq = freq[i];
            result = i;
        }
    }
    return result;
}