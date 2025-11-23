#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int absval(int x) {
    return x >= 0 ? x : -x;
}

int maxAbsValExpr(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    int max1 = 0, max2 = 0, max3 = 0, max4 = 0;
    int min1 = 0, min2 = 0, min3 = 0, min4 = 0;

    for (int i = 0; i < arr1Size; i++) {
        int val1 = arr1[i] + arr2[i];
        int val2 = arr1[i] - arr2[i];
        int val3 = -arr1[i] + arr2[i];
        int val4 = -arr1[i] - arr2[i];

        max1 = fmax(max1, val1);
        min1 = fmin(min1, val1);

        max2 = fmax(max2, val2);
        min2 = fmin(min2, val2);

        max3 = fmax(max3, val3);
        min3 = fmin(min3, val3);

        max4 = fmax(max4, val4);
        min4 = fmin(min4, val4);
    }

    int result = fmax(fmax(max1 - min1, max2 - min2), fmax(max3 - min3, max4 - min4));
    return result;
}