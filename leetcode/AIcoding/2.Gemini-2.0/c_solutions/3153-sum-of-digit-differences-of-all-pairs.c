#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int digitDiff(int a, int b) {
    int countA[10] = {0};
    int countB[10] = {0};
    if (a == 0) countA[0]++;
    while (a > 0) {
        countA[a % 10]++;
        a /= 10;
    }
    if (b == 0) countB[0]++;
    while (b > 0) {
        countB[b % 10]++;
        b /= 10;
    }
    int diff = 0;
    for (int i = 0; i < 10; i++) {
        diff += abs(countA[i] - countB[i]);
    }
    return diff;
}

long long sumDigitDifferences(int* nums, int numsSize) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            sum += digitDiff(nums[i], nums[j]);
        }
    }
    return 2 * sum;
}