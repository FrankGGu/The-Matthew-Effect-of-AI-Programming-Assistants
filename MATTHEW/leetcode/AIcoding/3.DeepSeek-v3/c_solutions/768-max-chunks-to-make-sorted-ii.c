int maxChunksToSorted(int* arr, int arrSize) {
    int* maxLeft = (int*)malloc(arrSize * sizeof(int));
    int* minRight = (int*)malloc(arrSize * sizeof(int));

    maxLeft[0] = arr[0];
    for (int i = 1; i < arrSize; i++) {
        maxLeft[i] = (arr[i] > maxLeft[i-1]) ? arr[i] : maxLeft[i-1];
    }

    minRight[arrSize-1] = arr[arrSize-1];
    for (int i = arrSize-2; i >= 0; i--) {
        minRight[i] = (arr[i] < minRight[i+1]) ? arr[i] : minRight[i+1];
    }

    int chunks = 0;
    for (int i = 0; i < arrSize-1; i++) {
        if (maxLeft[i] <= minRight[i+1]) {
            chunks++;
        }
    }

    free(maxLeft);
    free(minRight);

    return chunks + 1;
}