#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxAbsValExpr(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    int max1 = -2147483648, max2 = -2147483648, max3 = -2147483648, max4 = -2147483648;
    int min1 = 2147483647, min2 = 2147483647, min3 = 2147483647, min4 = 2147483647;
    for (int i = 0; i < arr1Size; i++) {
        int val1 = arr1[i] + arr2[i] + i;
        int val2 = arr1[i] - arr2[i] + i;
        int val3 = arr1[i] + arr2[i] - i;
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
    int ans1 = max1 - min1;
    int ans2 = max2 - min2;
    int ans3 = max3 - min3;
    int ans4 = max4 - min4;
    int ans = ans1;
    if (ans2 > ans) ans = ans2;
    if (ans3 > ans) ans = ans3;
    if (ans4 > ans) ans = ans4;
    return ans;
}