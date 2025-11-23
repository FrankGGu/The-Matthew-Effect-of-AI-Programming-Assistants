int findLeastNumOfUniqueInts(int* arr, int arrSize, int k) {
    int count[100001] = {0};
    int uniqueCount = 0;

    for (int i = 0; i < arrSize; i++) {
        if (count[arr[i]] == 0) uniqueCount++;
        count[arr[i]]++;
    }

    int frequencies[100001] = {0};
    for (int i = 0; i < 100001; i++) {
        if (count[i] > 0) frequencies[count[i]]++;
    }

    for (int i = 1; i <= arrSize; i++) {
        if (frequencies[i] > 0) {
            if (k >= i) {
                k -= i;
                uniqueCount -= frequencies[i];
            } else {
                break;
            }
        }
    }

    return uniqueCount;
}