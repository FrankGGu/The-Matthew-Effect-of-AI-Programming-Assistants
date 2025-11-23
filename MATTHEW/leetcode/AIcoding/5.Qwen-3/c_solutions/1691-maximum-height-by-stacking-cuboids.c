#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] != y[0]) return x[0] - y[0];
    if (x[1] != y[1]) return x[1] - y[1];
    return x[2] - y[2];
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maxHeight(int** cuboids, int cuboidsSize, int* cuboidsColSize) {
    qsort(cuboids, cuboidsSize, sizeof(int*), compare);

    int dp[cuboidsSize];
    for (int i = 0; i < cuboidsSize; i++) {
        dp[i] = cuboids[i][0];
        for (int j = 0; j < i; j++) {
            if (cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1] && cuboids[j][2] <= cuboids[i][2]) {
                dp[i] = max(dp[i], dp[j] + cuboids[i][0]);
            }
        }
    }

    int result = 0;
    for (int i = 0; i < cuboidsSize; i++) {
        result = max(result, dp[i]);
    }
    return result;
}