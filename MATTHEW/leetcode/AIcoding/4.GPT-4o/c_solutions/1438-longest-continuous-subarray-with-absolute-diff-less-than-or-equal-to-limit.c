#include <stdio.h>
#include <stdlib.h>

int longestSubarray(int* nums, int numsSize, int limit) {
    int left = 0, right = 0, maxLength = 0;
    int* maxDeque = (int*)malloc(numsSize * sizeof(int));
    int* minDeque = (int*)malloc(numsSize * sizeof(int));
    int maxFront = 0, minFront = 0;

    while (right < numsSize) {
        while (maxFront > 0 && maxDeque[maxFront - 1] < nums[right]) maxFront--;
        maxDeque[maxFront++] = nums[right];

        while (minFront > 0 && minDeque[minFront - 1] > nums[right]) minFront--;
        minDeque[minFront++] = nums[right];

        while (maxDeque[0] - minDeque[0] > limit) {
            if (maxDeque[0] == nums[left]) maxFront--;
            if (minDeque[0] == nums[left]) minFront--;
            left++;
        }

        maxLength = maxLength > (right - left + 1) ? maxLength : (right - left + 1);
        right++;
    }

    free(maxDeque);
    free(minDeque);
    return maxLength;
}