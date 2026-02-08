#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int maxFrequencyScore(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long prefixSum[numsSize + 1];
    prefixSum[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }
    int maxFreq = 1;
    for (int i = 0; i < numsSize; i++) {
        int left = 0;
        int right = i;
        int leftIdx = i;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long cost = (long long)nums[i] * (i - mid + 1) - (prefixSum[i + 1] - prefixSum[mid]);
            if (cost <= k) {
                leftIdx = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        left = i;
        right = numsSize - 1;
        int rightIdx = i;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long cost = (prefixSum[mid + 1] - prefixSum[i]) - (long long)nums[i] * (mid - i + 1);
            if (cost <= k) {
                rightIdx = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        int len1 = i - leftIdx + 1;
        int len2 = rightIdx - i;
        int freq = 1;

        left = 0;
        right = i;
        int left_idx = i;
        while(left <= right) {
            int mid = left + (right - left) / 2;
            long long cost = (long long)nums[i] * (i - mid + 1) - (prefixSum[i+1] - prefixSum[mid]);
            if(cost <= k) {
                left_idx = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        left = i;
        right = numsSize - 1;
        int right_idx = i;
        while(left <= right) {
            int mid = left + (right - left) / 2;
            long long cost = (prefixSum[mid+1] - prefixSum[i]) - (long long)nums[i] * (mid - i);
            if(cost <= k) {
                right_idx = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        freq = right_idx - left_idx + 1;

        if (freq > maxFreq) {
            maxFreq = freq;
        }
    }
    return maxFreq;
}