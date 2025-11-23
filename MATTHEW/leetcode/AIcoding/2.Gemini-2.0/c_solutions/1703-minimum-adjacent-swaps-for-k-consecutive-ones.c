#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwaps(int* nums, int numsSize, int k) {
    int onesCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            onesCount++;
        }
    }

    if (k > onesCount) {
        return 0;
    }

    int ones[onesCount];
    int onesIndex = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            ones[onesIndex++] = i;
        }
    }

    long long prefixSum[onesCount + 1];
    prefixSum[0] = 0;
    for (int i = 0; i < onesCount; i++) {
        prefixSum[i + 1] = prefixSum[i] + ones[i];
    }

    long long minCost = LLONG_MAX;
    for (int i = 0; i <= onesCount - k; i++) {
        int medianIndex = i + k / 2;
        long long median = ones[medianIndex];
        long long cost = 0;
        if (k % 2 == 0) {
            cost = (median * (k / 2) - (prefixSum[medianIndex + 1] - prefixSum[i + k / 2])) +
                   ((prefixSum[i + k] - prefixSum[medianIndex + 1]) - median * (k - k / 2));
        } else {
            cost = (median * (k / 2) - (prefixSum[medianIndex + 1] - prefixSum[i + k / 2])) +
                   ((prefixSum[i + k] - prefixSum[medianIndex + 1]) - median * (k - k / 2));
        }

        long long offset = 0;
        for (int j = 0; j < k; j++) {
            offset += abs(j - k / 2);
        }
        cost -= offset;

        if (cost < minCost) {
            minCost = cost;
        }
    }

    return (int)minCost;
}