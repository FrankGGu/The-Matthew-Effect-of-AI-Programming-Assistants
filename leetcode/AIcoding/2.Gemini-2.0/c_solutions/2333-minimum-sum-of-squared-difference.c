#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minSumSquareDiff(int* nums1, int nums1Size, int* nums2, int nums2Size, int k1, int k2) {
    int n = nums1Size;
    int* diff = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        diff[i] = abs(nums1[i] - nums2[i]);
    }

    int total_k = k1 + k2;

    for (int i = 0; i < total_k; i++) {
        int max_index = 0;
        for (int j = 1; j < n; j++) {
            if (diff[j] > diff[max_index]) {
                max_index = j;
            }
        }

        if (diff[max_index] > 0) {
            diff[max_index]--;
        } else {
            break;
        }
    }

    long long sum = 0;
    for (int i = 0; i < n; i++) {
        sum += (long long)diff[i] * diff[i];
    }

    free(diff);
    return sum;
}