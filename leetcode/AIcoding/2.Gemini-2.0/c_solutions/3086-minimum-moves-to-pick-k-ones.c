#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minMoves(int* nums, int numsSize, int k) {
    int onesCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            onesCount++;
        }
    }

    if (k > onesCount) {
        return -1;
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

    long long min_moves = LLONG_MAX;
    for (int i = 0; i <= onesCount - k; i++) {
        int mid = i + k / 2;
        long long current_moves = 0;
        if (k % 2 == 0) {
            current_moves = (long long)ones[mid] * (mid - i) - (prefixSum[mid] - prefixSum[i]) - (long long)(mid - i) * (mid - i + 1) / 2;
            current_moves += (prefixSum[i + k] - prefixSum[mid + 1]) - (long long)ones[mid] * (i + k - mid - 1) - (long long)(i + k - mid - 1) * (i + k - mid) / 2;
        } else {
            current_moves = (long long)ones[mid] * (mid - i) - (prefixSum[mid] - prefixSum[i]) - (long long)(mid - i) * (mid - i + 1) / 2;
            current_moves += (prefixSum[i + k] - prefixSum[mid + 1]) - (long long)ones[mid] * (i + k - mid - 1) - (long long)(i + k - mid - 1) * (i + k - mid) / 2;
        }
        if (current_moves < min_moves) {
            min_moves = current_moves;
        }
    }

    return min_moves;
}