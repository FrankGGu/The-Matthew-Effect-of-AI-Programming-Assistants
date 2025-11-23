int getXORSum(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    int xorSum1 = 0;
    for (int i = 0; i < arr1Size; i++) {
        xorSum1 ^= arr1[i];
    }

    int xorSum2 = 0;
    for (int i = 0; i < arr2Size; i++) {
        xorSum2 ^= arr2[i];
    }

    return xorSum1 & xorSum2;
}