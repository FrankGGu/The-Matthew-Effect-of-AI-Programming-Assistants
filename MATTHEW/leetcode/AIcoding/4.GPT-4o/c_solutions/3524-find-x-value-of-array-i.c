int findX(int* arr, int arrSize) {
    int x = 0;
    for (int i = 0; i < arrSize; i++) {
        x ^= arr[i] ^ i;
    }
    return x;
}