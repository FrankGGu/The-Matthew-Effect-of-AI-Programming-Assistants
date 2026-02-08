#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int *c = *(int **)a;
    int *d = *(int **)b;
    if (c[0] != d[0]) return c[0] - d[0];
    if (c[1] != d[1]) return c[1] - d[1];
    return c[2] - d[2];
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxHeight(int** cuboids, int cuboidsSize, int* cuboidsColSize){
    for (int i = 0; i < cuboidsSize; i++) {
        int a = cuboids[i][0], b = cuboids[i][1], c = cuboids[i][2];
        if (a < b) {
            int temp = a;
            a = b;
            b = temp;
        }
        if (a < c) {
            int temp = a;
            a = c;
            c = temp;
        }
        if (b < c) {
            int temp = b;
            b = c;
            c = temp;
        }
        cuboids[i][0] = a;
        cuboids[i][1] = b;
        cuboids[i][2] = c;
    }
    qsort(cuboids, cuboidsSize, sizeof(cuboids[0]), cmp);

    int dp[cuboidsSize];
    for (int i = 0; i < cuboidsSize; i++) {
        dp[i] = cuboids[i][2];
    }

    int ans = 0;
    for (int i = 0; i < cuboidsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1] && cuboids[j][2] <= cuboids[i][2]) {
                dp[i] = max(dp[i], dp[j] + cuboids[i][2]);
            }
        }
        ans = max(ans, dp[i]);
    }

    return ans;
}