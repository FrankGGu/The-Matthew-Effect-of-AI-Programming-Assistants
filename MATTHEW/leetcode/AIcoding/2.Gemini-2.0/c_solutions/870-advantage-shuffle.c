#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* advantageCount(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    *returnSize = nums1Size;
    int* result = (int*)malloc(sizeof(int) * nums1Size);
    int* indices = (int*)malloc(sizeof(int) * nums2Size);
    for (int i = 0; i < nums2Size; i++) {
        indices[i] = i;
    }

    int compare(const void* a, const void* b) {
        return nums2[*(int*)a] - nums2[*(int*)b];
    }

    qsort(indices, nums2Size, sizeof(int), compare);

    int compareNums1(const void* a, const void* b) {
        return *(int*)a - *(int*)b;
    }

    qsort(nums1, nums1Size, sizeof(int), compareNums1);

    int left = 0;
    int right = nums1Size - 1;

    for (int i = 0; i < nums2Size; i++) {
        if (nums1[right] > nums2[indices[i]]) {
            result[indices[i]] = nums1[right];
            right--;
        } else {
            result[indices[i]] = nums1[left];
            left++;
        }
    }

    free(indices);
    return result;
}