int countTriplets(int* arr, int arrSize) {
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        int xor = 0;
        for (int j = i; j < arrSize; j++) {
            xor ^= arr[j];
            if (xor == 0) {
                count += (j - i);
            }
        }
    }
    return count;
}