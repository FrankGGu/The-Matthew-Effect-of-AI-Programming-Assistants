int maxAbsValExpr(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    int maxVal = 0;
    for (int i = 0; i < 4; i++) {
        int sign1 = (i & 1) ? 1 : -1;
        int sign2 = (i & 2) ? 1 : -1;
        int currMax = 0;
        for (int j = 0; j < arr1Size; j++) {
            currMax = fmax(currMax, sign1 * arr1[j] + sign2 * arr2[j] + j);
        }
        for (int j = 0; j < arr1Size; j++) {
            currMax = fmax(currMax, sign1 * arr1[j] + sign2 * arr2[j] - j);
        }
        maxVal = fmax(maxVal, currMax);
    }
    return maxVal;
}