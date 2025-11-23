int uniqueMiddleModeI(int* arr, int arrSize) {
    int freq[1001] = {0};
    for (int i = 0; i < arrSize; i++) {
        freq[arr[i]]++;
    }

    int mode = -1, maxFreq = 0;
    for (int i = 0; i <= 1000; i++) {
        if (freq[i] > maxFreq) {
            maxFreq = freq[i];
            mode = i;
        } else if (freq[i] == maxFreq) {
            mode = -1;
        }
    }

    return mode;
}