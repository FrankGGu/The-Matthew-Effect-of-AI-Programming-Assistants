#include <stdio.h>
#include <stdlib.h>

int maximizeGreatness(int* nums, int numsSize) {
    int count[100001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int result = 0;
    int j = 0;
    for (int i = 0; i < 100001; i++) {
        while (count[i] > 0) {
            if (j < i) {
                result++;
                count[j]--;
            }
            count[i]--;
            j++;
        }
    }
    return result;
}