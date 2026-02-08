#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maximizeTheMinimum(int n, int k, int *nums, int numsSize) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    long long lo = 0;
    long long hi = sum / k;
    long long ans = 0;

    while (lo <= hi) {
        long long mid = lo + (hi - lo) / 2;
        long long count = 0;
        long long currentSum = 0;

        for (int i = 0; i < numsSize; i++) {
            currentSum += nums[i];
            if (currentSum >= mid) {
                count++;
                currentSum = 0;
            }
        }

        if (count >= k) {
            ans = mid;
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
    }

    return ans;
}