int* xorQueries(int* arr, int arrSize, int** queries, int queriesSize, int* returnSize) {
    int* prefixXor = (int*)malloc((arrSize + 1) * sizeof(int));
    prefixXor[0] = 0;
    for (int i = 1; i <= arrSize; i++) {
        prefixXor[i] = prefixXor[i - 1] ^ arr[i - 1];
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        result[i] = prefixXor[right + 1] ^ prefixXor[left];
    }

    free(prefixXor);
    *returnSize = queriesSize;
    return result;
}