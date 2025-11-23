#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minIncompatibility(int* nums, int numsSize, int k) {
    int n = numsSize;
    int total = 0;
    for (int i = 0; i < n; i++) total += nums[i];
    int target = total / k;

    qsort(nums, n, sizeof(int), compare);

    int* used = (int*)calloc(n, sizeof(int));
    int* subset = (int*)malloc(k * sizeof(int));
    int* sum = (int*)malloc(k * sizeof(int));
    int result = INT_MAX;

    void backtrack(int index, int count) {
        if (count == k) {
            result = 0;
            for (int i = 0; i < k; i++) result += sum[i];
            return;
        }

        for (int i = index; i < n; i++) {
            if (used[i]) continue;
            int canAdd = 1;
            for (int j = 0; j < k; j++) {
                if (sum[j] + nums[i] > target) {
                    canAdd = 0;
                    break;
                }
            }
            if (!canAdd) continue;

            used[i] = 1;
            for (int j = 0; j < k; j++) {
                if (sum[j] + nums[i] <= target) {
                    sum[j] += nums[i];
                    subset[count] = j;
                    backtrack(i + 1, count + 1);
                    sum[j] -= nums[i];
                    if (result != INT_MAX) return;
                }
            }
            used[i] = 0;
        }
    }

    backtrack(0, 0);
    free(used);
    free(subset);
    free(sum);
    return result;
}