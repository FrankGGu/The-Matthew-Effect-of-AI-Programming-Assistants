int maxDistinctElements(int* arr, int arrSize, int k) {
    int freq[100001] = {0};
    for (int i = 0; i < arrSize; i++) {
        freq[arr[i]]++;
    }

    int distinctCount = 0;
    int operationsUsed = 0;

    for (int i = 0; i <= 100000; i++) {
        if (freq[i] > 0) {
            distinctCount++;
        } else if (operationsUsed < k) {
            operationsUsed++;
            distinctCount++;
        }
    }

    return distinctCount;
}