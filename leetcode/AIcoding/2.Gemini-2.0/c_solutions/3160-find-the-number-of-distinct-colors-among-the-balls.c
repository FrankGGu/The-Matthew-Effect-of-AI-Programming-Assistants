#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxRepetitions(int* nums, int numsSize, int k) {
    long long low = 1, high = 1000000000;
    long long ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        long long count = 0;

        for (int i = 0; i < numsSize; i++) {
            count += (long long)fmin((long long)nums[i], mid);
        }

        if (count <= k) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += (long long)fmin((long long)nums[i], ans);
    }

    long long result = ans * numsSize;
    result -= (k - total);

    return (int)(result % 1000000007);
}