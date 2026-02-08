#include <stdio.h>
#include <stdlib.h>

int countNicePairs(int* nums, int numsSize) {
    int max = 0;
    for (int i = 0; i < numsSize; i++) {
        int rev = 0;
        int num = nums[i];
        while (num > 0) {
            rev = rev * 10 + num % 10;
            num /= 10;
        }
        nums[i] = nums[i] - rev;
        if (nums[i] > max) {
            max = nums[i];
        }
    }

    int* freq = (int*)calloc(max + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    long long count = 0;
    for (int i = 0; i <= max; i++) {
        if (freq[i] > 1) {
            count += (long long)freq[i] * (freq[i] - 1) / 2;
        }
    }

    free(freq);
    return (int)count;
}