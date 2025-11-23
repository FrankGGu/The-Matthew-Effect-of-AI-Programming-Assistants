#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int triangleNumber(int* nums, int numsSize) {
    if (numsSize < 3) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int count = 0;
    for (int i = 0; i < numsSize - 2; ++i) {
        if (nums[i] == 0) {
            continue;
        }

        int k = i + 2; 
        for (int j = i + 1; j < numsSize - 1; ++j) {
            if (k <= j) {
                k = j + 1;
            }

            while (k < numsSize && nums[k] < nums[i] + nums[j]) {
                k++;
            }
            count += (k - (j + 1));
        }
    }
    return count;
}