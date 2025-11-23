#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumMountainRemovals(int* nums, int numsSize) {
    int n = numsSize;
    int* lis = (int*)malloc(n * sizeof(int));
    int* lds = (int*)malloc(n * sizeof(int));
    int* tail = (int*)malloc(n * sizeof(int));
    int len;
    int i, j, k;
    int max_len = 0;

    for (i = 0; i < n; i++) {
        lis[i] = 1;
        lds[i] = 1;
    }

    for (i = 1; i < n; i++) {
        for (j = 0; j < i; j++) {
            if (nums[i] > nums[j]) {
                lis[i] = (lis[i] > lis[j] + 1) ? lis[i] : lis[j] + 1;
            }
        }
    }

    for (i = n - 2; i >= 0; i--) {
        for (j = n - 1; j > i; j--) {
            if (nums[i] > nums[j]) {
                lds[i] = (lds[i] > lds[j] + 1) ? lds[i] : lds[j] + 1;
            }
        }
    }

    for (i = 0; i < n; i++) {
        if (lis[i] > 1 && lds[i] > 1) {
            int current_len = lis[i] + lds[i] - 1;
            max_len = (max_len > current_len) ? max_len : current_len;
        }
    }

    free(lis);
    free(lds);
    free(tail);

    return n - max_len;
}