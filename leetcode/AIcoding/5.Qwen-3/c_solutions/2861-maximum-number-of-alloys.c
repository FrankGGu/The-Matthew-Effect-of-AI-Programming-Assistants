#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long maxNumberOfAlloys(int n, int k, int target, int* maxOperations, int* eachOperation) {
    long long left = 0;
    long long right = 1e18;
    long long ans = 0;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long total = 0;

        for (int i = 0; i < n; i++) {
            long long required = (long long)maxOperations[i] * (mid - eachOperation[i]);
            if (required > 0) {
                total += required;
            }
            if (total > target) break;
        }

        if (total <= target) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}