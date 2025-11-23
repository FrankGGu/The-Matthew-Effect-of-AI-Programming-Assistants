#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

long long minCost(int *nums, int numsSize, int k, int dist) {
    long long ans = -1;
    for (int i = 0; i <= numsSize - dist - 1; i++) {
        int temp[numsSize - 1];
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (j != i + dist + 1) {
                temp[count++] = nums[j];
            }
        }
        qsort(temp, numsSize - 1, sizeof(int), cmp);
        long long current_cost = (long long)nums[i + dist + 1];
        for (int j = 0; j < k - 1; j++) {
            current_cost += (long long)temp[j];
        }
        current_cost += (long long)nums[0];

        if (ans == -1 || current_cost < ans) {
            ans = current_cost;
        }
    }
    return ans;
}