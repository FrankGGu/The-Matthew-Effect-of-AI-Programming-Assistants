#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countExcellentPairs(int* nums, int numsSize, int k) {
    int count[32] = {0};
    int uniqueNums[numsSize];
    int uniqueSize = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int isUnique = 1;
        for (int j = 0; j < uniqueSize; j++) {
            if (uniqueNums[j] == num) {
                isUnique = 0;
                break;
            }
        }
        if (isUnique) {
            uniqueNums[uniqueSize++] = num;
        }
    }

    for (int i = 0; i < uniqueSize; i++) {
        int num = uniqueNums[i];
        int bits = 0;
        while (num > 0) {
            bits += (num & 1);
            num >>= 1;
        }
        count[bits]++;
    }

    long long result = 0;
    for (int i = 0; i < 32; i++) {
        if (count[i] > 0) {
            for (int j = 0; j < 32; j++) {
                if (count[j] > 0) {
                    if (i + j >= k) {
                        result += (long long)count[i] * count[j];
                    }
                }
            }
        }
    }

    return result;
}