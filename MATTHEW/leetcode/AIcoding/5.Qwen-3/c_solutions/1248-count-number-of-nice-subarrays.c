#include <stdio.h>
#include <stdlib.h>

int numberOfSubarrays(int* nums, int numsSize, int k) {
    int count[100001] = {0};
    int oddCount = 0;
    int result = 0;
    count[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 1) {
            oddCount++;
        }
        if (oddCount - k >= 0) {
            result += count[oddCount - k];
        }
        count[oddCount]++;
    }

    return result;
}