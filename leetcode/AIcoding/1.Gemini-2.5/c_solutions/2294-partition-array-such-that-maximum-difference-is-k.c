#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int partitionArray(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);

    int partitions = 0;
    int i = 0;

    while (i < numsSize) {
        partitions++;
        int min_val_in_current_partition = nums[i];
        int j = i;
        while (j < numsSize && nums[j] - min_val_in_current_partition <= k) {
            j++;
        }
        i = j;
    }

    return partitions;
}