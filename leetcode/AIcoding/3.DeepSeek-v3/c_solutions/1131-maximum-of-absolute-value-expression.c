int maxAbsValExpr(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    int max1 = INT_MIN, min1 = INT_MAX;
    int max2 = INT_MIN, min2 = INT_MAX;
    int max3 = INT_MIN, min3 = INT_MAX;
    int max4 = INT_MIN, min4 = INT_MAX;

    for (int i = 0; i < arr1Size; i++) {
        int val1 = arr1[i] + arr2[i] + i;
        int val2 = arr1[i] + arr2[i] - i;
        int val3 = arr1[i] - arr2[i] + i;
        int val4 = arr1[i] - arr2[i] - i;

        if (val1 > max1) max1 = val1;
        if (val1 < min1) min1 = val1;

        if (val2 > max2) max2 = val2;
        if (val2 < min2) min2 = val2;

        if (val3 > max3) max3 = val3;
        if (val3 < min3) min3 = val3;

        if (val4 > max4) max4 = val4;
        if (val4 < min4) min4 = val4;
    }

    int res1 = max1 - min1;
    int res2 = max2 - min2;
    int res3 = max3 - min3;
    int res4 = max4 - min4;

    int maxRes = res1;
    if (res2 > maxRes) maxRes = res2;
    if (res3 > maxRes) maxRes = res3;
    if (res4 > maxRes) maxRes = res4;

    return maxRes;
}