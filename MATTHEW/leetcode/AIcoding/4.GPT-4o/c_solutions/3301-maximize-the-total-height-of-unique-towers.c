#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)b - *(int *)a);
}

int maxHeight(int* A, int ASize) {
    int dp[ASize + 1];
    int maxHeight = 0;

    qsort(A, ASize, sizeof(int), cmp);

    for (int i = 0; i <= ASize; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < ASize; i++) {
        for (int j = i; j >= 0; j--) {
            if (dp[j] + A[i] > dp[j + 1]) {
                dp[j + 1] = dp[j] + A[i];
            }
        }
    }

    for (int i = 0; i <= ASize; i++) {
        maxHeight = maxHeight > dp[i] ? maxHeight : dp[i];
    }

    return maxHeight;
}