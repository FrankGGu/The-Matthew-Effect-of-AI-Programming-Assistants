int countTriplets(int* arr, int arrSize) {
    int count = 0;
    int *prefixXor = (int*)malloc((arrSize + 1) * sizeof(int));
    prefixXor[0] = 0;

    for (int i = 0; i < arrSize; i++) {
        prefixXor[i + 1] = prefixXor[i] ^ arr[i];
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            if (prefixXor[i] == prefixXor[j + 1]) {
                count += j - i;
            }
        }
    }

    free(prefixXor);
    return count;
}