#include <stdio.h>
#include <stdlib.h>

int* findDifference(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (nums1Size + nums2Size));
    int index = 0;
    int* hash1 = (int*)calloc(1001, sizeof(int));
    int* hash2 = (int*)calloc(1001, sizeof(int));

    for (int i = 0; i < nums1Size; i++) {
        hash1[nums1[i]] = 1;
    }

    for (int i = 0; i < nums2Size; i++) {
        hash2[nums2[i]] = 1;
    }

    for (int i = 0; i < 1001; i++) {
        if (hash1[i] && !hash2[i]) {
            result[index++] = i;
        }
    }

    *returnSize = index;
    return result;
}