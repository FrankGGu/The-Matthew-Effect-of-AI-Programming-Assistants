#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* advantageCount(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(nums1Size * sizeof(int));
    int* nums2Copy = (int*)malloc(nums2Size * sizeof(int));
    memcpy(nums2Copy, nums2, nums2Size * sizeof(int));

    qsort(nums1, nums1Size, sizeof(int), compare);
    qsort(nums2Copy, nums2Size, sizeof(int), compare);

    int* indexMap = (int*)malloc(nums2Size * sizeof(int));
    for (int i = 0; i < nums2Size; i++) {
        indexMap[i] = i;
    }

    qsort(indexMap, nums2Size, sizeof(int), compare);

    int left = 0, right = nums1Size - 1;
    int* resultIndex = (int*)malloc(nums1Size * sizeof(int));
    for (int i = 0; i < nums2Size; i++) {
        if (nums1[right] > nums2Copy[i]) {
            resultIndex[indexMap[i]] = nums1[right];
            right--;
        } else {
            resultIndex[indexMap[i]] = nums1[left];
            left++;
        }
    }

    *returnSize = nums1Size;
    free(nums2Copy);
    free(indexMap);
    free(result);
    return resultIndex;
}