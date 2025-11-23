#include <stdio.h>
#include <stdlib.h>

int mostFrequentEven(int* nums, int numsSize) {
    int count[100000] = {0};
    int maxFreq = -1;
    int result = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            count[nums[i]]++;
            if (count[nums[i]] > maxFreq || (count[nums[i]] == maxFreq && nums[i] < result)) {
                maxFreq = count[nums[i]];
                result = nums[i];
            }
        }
    }

    return result;
}