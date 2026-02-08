#include <stdlib.h>

int* findDifference(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* diff1 = malloc(nums1Size * sizeof(int));
    int* diff2 = malloc(nums2Size * sizeof(int));
    int size1 = 0, size2 = 0;

    for (int i = 0; i < nums1Size; i++) {
        int found = 0;
        for (int j = 0; j < nums2Size; j++) {
            if (nums1[i] == nums2[j]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            diff1[size1++] = nums1[i];
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        int found = 0;
        for (int j = 0; j < nums1Size; j++) {
            if (nums2[i] == nums1[j]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            diff2[size2++] = nums2[i];
        }
    }

    int* result = malloc((size1 + size2) * sizeof(int));
    *returnSize = 2;
    result[0] = size1;
    result[1] = size2;

    for (int i = 0; i < size1; i++) {
        result[i + 2] = diff1[i];
    }
    for (int i = 0; i < size2; i++) {
        result[i + 2 + size1] = diff2[i];
    }

    free(diff1);
    free(diff2);
    return result;
}