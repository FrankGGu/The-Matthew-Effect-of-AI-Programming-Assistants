int getXORSum(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    int xor1 = 0, xor2 = 0;
    for (int i = 0; i < arr1Size; i++) {
        xor1 ^= arr1[i];
    }
    for (int i = 0; i < arr2Size; i++) {
        xor2 ^= arr2[i];
    }
    return xor1 & xor2;
}