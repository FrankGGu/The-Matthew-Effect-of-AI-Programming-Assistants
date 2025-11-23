#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxAbsValExpr(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    int max_val[4];
    int min_val[4];

    for (int i = 0; i < 4; ++i) {
        max_val[i] = INT_MIN;
        min_val[i] = INT_MAX;
    }

    for (int k = 0; k < arr1Size; ++k) {
        int v0 = arr1[k] + arr2[k] + k;
        int v1 = arr1[k] + arr2[k] - k;
        int v2 = arr1[k] - arr2[k] + k;
        int v3 = arr1[k] - arr2[k] - k;

        max_val[0] = max(max_val[0], v0);
        min_val[0] = min(min_val[0], v0);

        max_val[1] = max(max_val[1], v1);
        min_val[1] = min(min_val[1], v1);

        max_val[2] = max(max_val[2], v2);
        min_val[2] = min(min_val[2], v2);

        max_val[3] = max(max_val[3], v3);
        min_val[3] = min(min_val[3], v3);
    }

    int result = 0;
    for (int i = 0; i < 4; ++i) {
        result = max(result, max_val[i] - min_val[i]);
    }

    return result;
}