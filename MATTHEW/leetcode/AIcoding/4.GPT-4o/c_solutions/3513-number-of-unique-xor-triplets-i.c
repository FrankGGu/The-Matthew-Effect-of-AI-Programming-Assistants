int countTriplets(int* arr, int arrSize) {
    int count = 0;
    int* hash = (int*)calloc(1 << 16, sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            int xorValue = arr[i] ^ arr[j];
            if (!hash[xorValue]) {
                count++;
                hash[xorValue] = 1;
            }
        }
    }

    free(hash);
    return count;
}