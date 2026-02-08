#include <stdlib.h>

int* findIntersectionValues(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 2;

    result[0] = 0;
    result[1] = 0;

    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            if (nums1[i] == nums2[j]) {
                result[0]++;
                break;
            }
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        for (int j = 0; j < nums1Size; j++) {
            if (nums2[i] == nums1[j]) {
                result[1]++;
                break;
            }
        }
    }

    return result;
}