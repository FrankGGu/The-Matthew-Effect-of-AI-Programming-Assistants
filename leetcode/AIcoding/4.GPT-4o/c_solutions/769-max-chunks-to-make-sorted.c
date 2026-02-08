int maxChunksToSorted(int* arr, int arrSize) {
    int maxVal = 0, chunks = 0;
    for (int i = 0; i < arrSize; i++) {
        maxVal = maxVal > arr[i] ? maxVal : arr[i];
        if (maxVal == i) {
            chunks++;
        }
    }
    return chunks;
}