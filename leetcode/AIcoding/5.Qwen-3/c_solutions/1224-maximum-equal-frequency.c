#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int key;
    int count;
} Pair;

int maxEqualFreq(int* nums, int numsSize) {
    int maxFreq = 0;
    int freq[100001] = {0};
    int count[100001] = {0};
    int unique = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (freq[num] == 0) {
            unique++;
        }
        count[freq[num]]--;
        freq[num]++;
        count[freq[num]]++;
        maxFreq = (maxFreq < freq[num]) ? freq[num] : maxFreq;

        if ((maxFreq == 1) || (unique == 1) || (count[maxFreq] == 1 && count[maxFreq - 1] + 1 == unique)) {
            return i + 1;
        }
    }

    return numsSize;
}