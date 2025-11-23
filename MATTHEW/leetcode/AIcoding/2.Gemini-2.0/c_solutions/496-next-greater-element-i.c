#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* nextGreaterElement(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int *result = (int*)malloc(nums1Size * sizeof(int));
    *returnSize = nums1Size;

    for (int i = 0; i < nums1Size; i++) {
        result[i] = -1;
        int found = 0;
        for (int j = 0; j < nums2Size; j++) {
            if (nums1[i] == nums2[j]) {
                found = 1;
            }
            if (found && nums2[j] > nums1[i]) {
                result[i] = nums2[j];
                break;
            }
        }
    }

    return result;
}