#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int countBeautifulPairs(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int a = nums[i];
            int b = nums[j];
            while (a >= 10) a /= 10;
            while (b >= 10) b %= 10;
            if ((a + b) % k == 0) count++;
        }
    }
    return count;
}