int maxChunksToSorted(int* arr, int arrSize) {
    int chunks = 0;
    int max_reach = 0;

    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > max_reach) {
            max_reach = arr[i];
        }

        if (max_reach == i) {
            chunks++;
        }
    }

    return chunks;
}