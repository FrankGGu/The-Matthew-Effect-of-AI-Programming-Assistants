#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minMoves(int* nums, int numsSize) {
    int n = numsSize;
    int* diff = (int*)calloc(2 * n + 2, sizeof(int));

    for (int i = 0; i < n; i++) {
        int a = nums[i];
        for (int j = i + 1; j < n; j++) {
            int b = nums[j];
            int min_val = 1;
            int max_val = 2 * n;
            int target = a + b;
            diff[min_val]++;
            diff[max_val + 1]--;
        }
    }

    int res = INT_MAX;
    int current = 0;
    for (int i = 1; i <= 2 * n; i++) {
        current += diff[i];
        res = (current < res) ? current : res;
    }

    free(diff);
    return res;
}