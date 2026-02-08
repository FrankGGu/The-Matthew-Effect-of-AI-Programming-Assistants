#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maxArray(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * k);
    *returnSize = 0;
    int drop = numsSize - k;
    for (int i = 0; i < numsSize; i++) {
        while (*returnSize > 0 && result[*returnSize - 1] < nums[i] && drop > 0) {
            (*returnSize)--;
            drop--;
        }
        if (*returnSize < k) {
            result[(*returnSize)++] = nums[i];
        } else {
            drop--;
        }
    }
    return result;
}

int compare(int* nums1, int i, int* nums2, int j, int nums1Size, int nums2Size) {
    while (i < nums1Size && j < nums2Size && nums1[i] == nums2[j]) {
        i++;
        j++;
    }
    if (i == nums1Size && j == nums2Size) return 0;
    if (i == nums1Size) return -1;
    if (j == nums2Size) return 1;
    return nums1[i] - nums2[j];
}

int* merge(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (nums1Size + nums2Size));
    *returnSize = 0;
    int i = 0, j = 0;
    while (i < nums1Size || j < nums2Size) {
        if (compare(nums1, i, nums2, j, nums1Size, nums2Size) > 0) {
            result[(*returnSize)++] = nums1[i++];
        } else {
            result[(*returnSize)++] = nums2[j++];
        }
    }
    return result;
}

int* maxNumber(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize) {
    int* max_result = (int*)malloc(sizeof(int) * k);
    memset(max_result, 0, sizeof(int) * k);
    *returnSize = k;
    for (int i = 0; i <= k; i++) {
        if (i <= nums1Size && k - i <= nums2Size) {
            int* arr1, *arr2, *merged;
            int size1, size2, merged_size;

            arr1 = maxArray(nums1, nums1Size, i, &size1);
            arr2 = maxArray(nums2, nums2Size, k - i, &size2);
            merged = merge(arr1, size1, arr2, size2, &merged_size);

            if (compare(merged, 0, max_result, 0, merged_size, k) > 0) {
                memcpy(max_result, merged, sizeof(int) * k);
            }

            free(arr1);
            free(arr2);
            free(merged);
        }
    }
    return max_result;
}