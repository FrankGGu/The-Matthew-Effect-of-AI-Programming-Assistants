#include <stdio.h>
#include <stdlib.h>

int* circularGameLosers(int n, int k, int* returnSize) {
    int* losers = (int*)malloc(n * sizeof(int));
    int* eliminated = (int*)calloc(n, sizeof(int));
    int count = 0;
    int position = 0;

    for (int i = 1; i <= n; i++) {
        position = (position + k - 1) % (n - i + 1);
        int j = 0, eliminatedCount = 0;
        while (eliminatedCount <= position) {
            if (!eliminated[j]) {
                if (eliminatedCount == position) {
                    eliminated[j] = 1;
                }
                eliminatedCount++;
            }
            j++;
        }
    }

    for (int i = 0; i < n; i++) {
        if (!eliminated[i]) {
            losers[count++] = i + 1;
        }
    }

    free(eliminated);
    *returnSize = count;
    return losers;
}