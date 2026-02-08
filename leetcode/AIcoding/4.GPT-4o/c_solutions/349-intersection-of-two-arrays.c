#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* intersection(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    qsort(nums1, nums1Size, sizeof(int), cmpfunc);
    qsort(nums2, nums2Size, sizeof(int), cmpfunc);

    int* result = (int*)malloc(sizeof(int) * (nums1Size < nums2Size ? nums1Size : nums2Size));
    *returnSize = 0;

    int i = 0, j = 0;
    while (i < nums1Size && j < nums2Size) {
        if (nums1[i] < nums2[j]) {
            i++;
        } else if (nums1[i] > nums2[j]) {
            j++;
        } else {
            if (*returnSize == 0 || result[*returnSize - 1] != nums1[i]) {
                result[*returnSize] = nums1[i];
                (*returnSize)++;
            }
            i++;
            j++;
        }
    }

    return result;
}