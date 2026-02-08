#include <stdio.h>
#include <stdlib.h>

int* nextGreaterElement(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(nums1Size * sizeof(int));
    int* nextGreater = (int*)malloc(nums2Size * sizeof(int));
    int* stack = (int*)malloc(nums2Size * sizeof(int));
    int top = -1;

    for (int i = 0; i < nums2Size; ++i) {
        while (top >= 0 && nums2[stack[top]] < nums2[i]) {
            int index = stack[top--];
            nextGreater[index] = nums2[i];
        }
        stack[++top] = i;
    }

    while (top >= 0) {
        nextGreater[stack[top--]] = -1;
    }

    for (int i = 0; i < nums1Size; ++i) {
        for (int j = 0; j < nums2Size; ++j) {
            if (nums1[i] == nums2[j]) {
                result[i] = nextGreater[j];
                break;
            }
        }
    }

    *returnSize = nums1Size;
    free(stack);
    free(nextGreater);
    return result;
}