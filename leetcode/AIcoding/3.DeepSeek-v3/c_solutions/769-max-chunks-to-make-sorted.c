int maxChunksToSorted(int* arr, int arrSize) {
    int max_val = 0;
    int chunks = 0;

    for (int i = 0; i < arrSize; i++) {
        max_val = (arr[i] > max_val) ? arr[i] : max_val;
        if (max_val == i) {
            chunks++;
        }
    }

    return chunks;
}