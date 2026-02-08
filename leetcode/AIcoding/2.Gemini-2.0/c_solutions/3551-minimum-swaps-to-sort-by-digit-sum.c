#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int digit_sum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int minSwaps(int* nums, int numsSize) {
    int *sums = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        sums[i] = digit_sum(nums[i]);
    }

    int swaps = 0;
    int *index = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        index[i] = i;
    }

    for (int i = 0; i < numsSize; i++) {
        int min_index = i;
        for (int j = i + 1; j < numsSize; j++) {
            if (sums[j] < sums[min_index] || (sums[j] == sums[min_index] && nums[j] < nums[min_index])) {
                min_index = j;
            }
        }

        if (min_index != i) {
            int temp = sums[i];
            sums[i] = sums[min_index];
            sums[min_index] = temp;

            temp = nums[i];
            nums[i] = nums[min_index];
            nums[min_index] = temp;
            swaps++;
        }
    }

    free(sums);
    free(index);
    return swaps;
}