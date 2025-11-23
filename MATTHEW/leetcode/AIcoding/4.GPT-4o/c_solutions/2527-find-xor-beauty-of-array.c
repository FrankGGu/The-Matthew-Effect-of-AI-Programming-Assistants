int xorBeauty(int* arr, int arrSize) {
    int result = 0;
    for (int i = 0; i < arrSize; i++) {
        result ^= arr[i];
    }
    return result;
}