#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long sumOfDividors(int n) {
    long long sum = 1;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            sum += i;
            if (i * i != n) {
                sum += n / i;
            }
        }
    }
    if (n > 1) sum += n;
    return sum;
}

long long maxFactorScore(int* nums, int numsSize) {
    long long maxScore = 0;
    for (int i = 0; i < numsSize; i++) {
        long long score = sumOfDividors(nums[i]);
        if (score > maxScore) {
            maxScore = score;
        }
    }
    return maxScore;
}