#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maxBalancedSubsequenceSum(int* nums, int numsSize) {
    int* sorted = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i] - (i + 1);
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (sorted[i] > sorted[j]) {
                int temp = sorted[i];
                sorted[i] = sorted[j];
                sorted[j] = temp;
            }
        }
    }

    int* compressed = (int*)malloc(sizeof(int) * numsSize);
    int compressedSize = 0;
    if (numsSize > 0) {
        compressed[compressedSize++] = sorted[0];
        for (int i = 1; i < numsSize; i++) {
            if (sorted[i] != sorted[i - 1]) {
                compressed[compressedSize++] = sorted[i];
            }
        }
    }

    long long* bit = (long long*)calloc(compressedSize + 1, sizeof(long long));

    long long maxVal = 0;

    for (int i = 0; i < numsSize; i++) {
        int index = -1;
        int left = 0, right = compressedSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (compressed[mid] == nums[i] - (i + 1)) {
                index = mid;
                break;
            } else if (compressed[mid] < nums[i] - (i + 1)) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        long long currentMax = 0;
        int idx = index + 1;
        while (idx > 0) {
            if (bit[idx] > currentMax) {
                currentMax = bit[idx];
            }
            idx -= (idx & -idx);
        }

        currentMax += nums[i];

        maxVal = (maxVal > currentMax) ? maxVal : currentMax;

        idx = index + 1;
        while (idx <= compressedSize) {
            if (currentMax > bit[idx]) {
                bit[idx] = currentMax;
            }
            idx += (idx & -idx);
        }
    }

    free(sorted);
    free(compressed);
    free(bit);

    return maxVal;
}