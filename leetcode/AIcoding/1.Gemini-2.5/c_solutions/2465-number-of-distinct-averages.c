#include <stdlib.h>
#include <stdbool.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int distinctAverages(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    bool seen_sums[201] = {false};
    int distinct_count = 0;

    int left = 0;
    int right = numsSize - 1;

    while (left < right) {
        int current_sum = nums[left] + nums[right];

        if (!seen_sums[current_sum]) {
            seen_sums[current_sum] = true;
            distinct_count++;
        }

        left++;
        right--;
    }

    return distinct_count;
}