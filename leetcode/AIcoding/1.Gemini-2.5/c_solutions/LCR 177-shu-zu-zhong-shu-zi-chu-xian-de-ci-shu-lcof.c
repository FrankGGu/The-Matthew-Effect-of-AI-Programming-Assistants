#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int getClashPairs(int* nums, int numsSize) {
    if (numsSize < 2) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    long long total_pairs = (long long)numsSize * (numsSize - 1) / 2;
    long long same_value_pairs = 0;

    int i = 0;
    while (i < numsSize) {
        int current_val = nums[i];
        int count = 0;
        int j = i;
        while (j < numsSize && nums[j] == current_val) {
            count++;
            j++;
        }
        if (count > 1) {
            same_value_pairs += (long long)count * (count - 1) / 2;
        }
        i = j;
    }

    return (int)(total_pairs - same_value_pairs);
}