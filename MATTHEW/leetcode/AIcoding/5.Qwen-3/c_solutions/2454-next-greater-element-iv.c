#include <stdio.h>
#include <stdlib.h>

int* nextGreaterElement(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* nextGreater = (int*)malloc(nums1Size * sizeof(int));
    int* indexMap = (int*)malloc(10000 * sizeof(int));
    for (int i = 0; i < 10000; i++) {
        indexMap[i] = -1;
    }
    for (int i = 0; i < nums2Size; i++) {
        indexMap[nums2[i]] = i;
    }

    for (int i = 0; i < nums1Size; i++) {
        int num = nums1[i];
        int idx = indexMap[num];
        int found = -1;
        for (int j = idx + 1; j < nums2Size; j++) {
            if (nums2[j] > num) {
                found = nums2[j];
                break;
            }
        }
        nextGreater[i] = found;
    }

    *returnSize = nums1Size;
    return nextGreater;
}