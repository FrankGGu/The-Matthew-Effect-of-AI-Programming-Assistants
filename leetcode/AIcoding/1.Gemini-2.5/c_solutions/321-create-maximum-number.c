#include <stdlib.h>
#include <stdbool.h>

bool compare(int* nums1, int len1, int* nums2, int len2) {
    for (int i = 0; i < len1 && i < len2; ++i) {
        if (nums1[i] > nums2[i]) {
            return true;
        }
        if (nums1[i] < nums2[i]) {
            return false;
        }
    }
    return len1 > len2;
}

int* getMaxSubsequence(int* nums, int numsSize, int k) {
    if (k == 0) {
        return (int*)malloc(0);
    }
    int* result = (int*)malloc(k * sizeof(int));
    int resultIdx = 0;

    int drop = numsSize - k;

    for (int i = 0; i < numsSize; ++i) {
        while (resultIdx > 0 && result[resultIdx - 1] < nums[i] && drop > 0) {
            resultIdx--;
            drop--;
        }
        if (resultIdx < k) {
            result[resultIdx++] = nums[i];
        } else {
            drop--;
        }
    }
    return result;
}

int* merge(int* nums1, int len1, int* nums2, int len2) {
    int total_len = len1 + len2;
    if (total_len == 0) {
        return (int*)malloc(0);
    }
    int* result = (int*)malloc(total_len * sizeof(int));
    int p1 = 0, p2 = 0, res_idx = 0;

    while (res_idx < total_len) {
        if (compare(nums1 + p1, len1 - p1, nums2 + p2, len2 - p2)) {
            result[res_idx++] = nums1[p1++];
        } else {
            result[res_idx++] = nums2[p2++];
        }
    }
    return result;
}

int* maxNumber(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    int* final_result = (int*)calloc(k, sizeof(int)); 

    for (int i = 0; i <= k; ++i) {
        int j = k - i;

        if (i > nums1Size || j > nums2Size) {
            continue;
        }

        int* sub1 = getMaxSubsequence(nums1, nums1Size, i);
        int* sub2 = getMaxSubsequence(nums2, nums2Size, j);

        int* merged = merge(sub1, i, sub2, j);

        if (compare(merged, k, final_result, k)) {
            for (int x = 0; x < k; ++x) {
                final_result[x] = merged[x];
            }
        }

        free(sub1);
        free(sub2);
        free(merged);
    }

    return final_result;
}