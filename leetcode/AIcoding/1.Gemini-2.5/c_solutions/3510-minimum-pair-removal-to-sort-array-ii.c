#include <stdlib.h>

int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int* tails = (int*)malloc(sizeof(int) * numsSize);
    int len = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];

        int low = 0;
        int high = len;

        while (low < high) {
            int mid = low + (high - low) / 2;
            if (tails[mid] < num) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        if (low == len) {
            tails[len++] = num;
        } else {
            tails[low] = num;
        }
    }

    free(tails);
    return len;
}

int minimumPairRemoval(int* nums, int numsSize) {
    int lis_length = lengthOfLIS(nums, numsSize);
    return numsSize - lis_length;
}