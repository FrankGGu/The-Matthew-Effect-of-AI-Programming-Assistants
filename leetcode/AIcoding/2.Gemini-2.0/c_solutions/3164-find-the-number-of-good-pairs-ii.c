#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countGoodPairs(int* nums, int numsSize, int k) {
    int count = 0;
    int* freq = (int*)malloc(sizeof(int) * 100001);
    for (int i = 0; i <= 100000; i++) {
        freq[i] = 0;
    }
    for (int i = 0; i < numsSize; i++) {
        int val = nums[i] % k;
        if (val < 0) val += k;
        count += freq[val];
        freq[val]++;
    }
    free(freq);
    return count;
}