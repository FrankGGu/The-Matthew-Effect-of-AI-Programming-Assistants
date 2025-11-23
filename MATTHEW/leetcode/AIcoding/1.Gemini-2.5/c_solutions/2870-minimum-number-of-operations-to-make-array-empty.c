#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumOperations(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int total_operations = 0;
    int i = 0;
    while (i < numsSize) {
        int current_num = nums[i];
        int count = 0;
        int j = i;
        while (j < numsSize && nums[j] == current_num) {
            count++;
            j++;
        }

        if (count == 1) {
            return -1;
        }

        total_operations += (count + 2) / 3;

        i = j;
    }

    return total_operations;
}