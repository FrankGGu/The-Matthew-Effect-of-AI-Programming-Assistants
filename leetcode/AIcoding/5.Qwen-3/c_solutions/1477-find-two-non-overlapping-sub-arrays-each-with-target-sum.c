#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int abs(int a) {
    return a < 0 ? -a : a;
}

int findTwoNonOverlappingSubarraysWithTargetSum(int* nums, int numsSize, int target) {
    int n = numsSize;
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));
    int* prefix = (int*)malloc(n * sizeof(int));
    int* suffix = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        prefix[i] = (i == 0) ? nums[i] : prefix[i-1] + nums[i];
    }

    for (int i = n - 1; i >= 0; i--) {
        suffix[i] = (i == n - 1) ? nums[i] : suffix[i+1] + nums[i];
    }

    for (int i = 0; i < n; i++) {
        left[i] = -1;
        for (int j = 0; j < i; j++) {
            if (prefix[i] - prefix[j] == target) {
                left[i] = j;
                break;
            }
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        right[i] = -1;
        for (int j = n - 1; j > i; j--) {
            if (suffix[i] - suffix[j] == target) {
                right[i] = j;
                break;
            }
        }
    }

    int result = INT_MAX;

    for (int i = 0; i < n; i++) {
        if (left[i] != -1) {
            for (int j = i + 1; j < n; j++) {
                if (right[j] != -1 && right[j] > i) {
                    result = min(result, (i - left[i]) + (right[j] - j));
                }
            }
        }
    }

    free(left);
    free(right);
    free(prefix);
    free(suffix);

    return (result == INT_MAX) ? -1 : result;
}