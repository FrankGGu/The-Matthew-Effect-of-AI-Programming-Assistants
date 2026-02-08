#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* recoverArray(int* nums, int numsSize, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), [](const void* a, const void* b) {
        return (*(int*)a - *(int*)b);
    });

    for (int i = 1; i < numsSize; i++) {
        if ((nums[i] - nums[0]) % 2 != 0) continue;
        int k = (nums[i] - nums[0]) / 2;
        if (k == 0) continue;

        int* ans = (int*)malloc(sizeof(int) * (numsSize / 2));
        int ansIdx = 0;
        int* counts = (int*)calloc(200001, sizeof(int));

        for (int j = 0; j < numsSize; j++) {
            counts[nums[j] + 100000]++;
        }

        bool possible = true;
        for (int j = 0; j < numsSize; j++) {
            if (counts[nums[j] + 100000] == 0) continue;
            counts[nums[j] + 100000]--;
            if (counts[nums[j] + 2 * k + 100000] > 0) {
                counts[nums[j] + 2 * k + 100000]--;
                ans[ansIdx++] = nums[j] + k;
            } else {
                possible = false;
                break;
            }
        }

        free(counts);

        if (possible) {
            *returnSize = numsSize / 2;
            return ans;
        } else {
            free(ans);
        }
    }

    *returnSize = 0;
    return NULL;
}