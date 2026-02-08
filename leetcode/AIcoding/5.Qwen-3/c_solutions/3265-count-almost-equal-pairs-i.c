#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countAlmostEqualPairs(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int diff = 0;
            int a = nums[i], b = nums[j];
            while (a > 0 || b > 0) {
                if (a % 10 != b % 10) {
                    diff++;
                }
                a /= 10;
                b /= 10;
            }
            if (diff <= 2) {
                count++;
            }
        }
    }
    return count;
}