#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* dp[1000];

int canReach(int* stones, int start, int jump, int size) {
    if (start == size - 1) return 1;
    if (dp[start] == NULL) return 0;
    for (int i = 0; i < dp[start]->size; i++) {
        int next = start + dp[start]->data[i];
        if (next < size && stones[next] - stones[start] == dp[start]->data[i]) {
            if (canReach(stones, next, dp[start]->data[i], size)) return 1;
        }
    }
    return 0;
}

int canCross(int* stones, int stonesSize) {
    qsort(stones, stonesSize, sizeof(int), cmp);
    for (int i = 0; i < stonesSize; i++) {
        dp[i] = (int*)malloc(sizeof(int) * stonesSize);
        dp[i][0] = 0;
    }
    for (int i = 1; i < stonesSize; i++) {
        for (int j = 0; j < i; j++) {
            int diff = stones[i] - stones[j];
            if (diff <= i) {
                int k = 0;
                while (k < dp[j][0] && dp[j][k+1] != diff) k++;
                if (k < dp[j][0] || (dp[j][0] == 0 && diff == 0)) {
                    dp[i][++dp[i][0]] = diff;
                }
            }
        }
    }
    return canReach(stones, 0, 0, stonesSize);
}