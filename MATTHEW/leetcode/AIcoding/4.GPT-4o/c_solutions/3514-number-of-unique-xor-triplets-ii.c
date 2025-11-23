int countTriplets(int* arr, int arrSize) {
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j < arrSize; j++) {
            for (int k = j + 1; k < arrSize; k++) {
                int xorValue = arr[i] ^ arr[j] ^ arr[k];
                if (xorValue == 0) {
                    count++;
                }
            }
        }
    }
    return count;
}