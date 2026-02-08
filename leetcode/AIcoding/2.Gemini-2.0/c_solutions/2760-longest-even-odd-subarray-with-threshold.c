#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestEvenOddSubarray(int* nums, int numsSize, int threshold) {
    int maxLen = 0;
    int currentLen = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > threshold) {
            currentLen = 0;
            continue;
        }
        if (i == 0 || (nums[i] % 2 != nums[i - 1] % 2)) {
            if (nums[i] % 2 == 0) {
                currentLen = 1;
                for (int j = i + 1; j < numsSize; j++) {
                    if (nums[j] > threshold) {
                        break;
                    }
                    if (nums[j] % 2 != nums[j - 1] % 2) {
                        currentLen++;
                    } else {
                        break;
                    }
                }
                maxLen = (currentLen > maxLen) ? currentLen : maxLen;
                currentLen = 0;
            }

        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > threshold) continue;
        if (nums[i] % 2 == 0) {
            currentLen = 0;
            if(nums[i] <= threshold) {
                currentLen = 1;
                for(int j = i + 1; j < numsSize; j++) {
                    if(nums[j] > threshold) break;
                    if(nums[j] % 2 != nums[j - 1] % 2) currentLen++;
                    else break;
                }
            }
            maxLen = (currentLen > maxLen) ? currentLen : maxLen;
        }
    }

    return maxLen;
}