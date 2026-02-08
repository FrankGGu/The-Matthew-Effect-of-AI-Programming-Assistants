#include <stdio.h>
#include <stdlib.h>

long long countSubseq(int* nums, int n, int target) {
    long long count = 0;
    for (int i = 0; i < n; i++) {
        long long sum = 0;
        for (int j = i; j < n; j++) {
            sum += nums[j];
            if (sum <= target) {
                count++;
            } else {
                break;
            }
        }
    }
    return count;
}

int numSubseqsToSumWithTarget(int* nums, int numsSize, int target) {
    long long count = 0;
    for (int i = 0; i < numsSize; i++) {
        long long sum = 0;
        for (int j = i; j < numsSize; j++) {
            sum += nums[j];
            if (sum <= target) {
                count++;
            } else {
                break;
            }
        }
    }
    return (int)count;
}