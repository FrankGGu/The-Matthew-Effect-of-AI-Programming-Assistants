#include <stdio.h>
#include <stdlib.h>

int* intersection(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* hash = (int*)calloc(1001, sizeof(int));
    int* result = NULL;
    int count = 0;

    for (int i = 0; i < nums1Size; i++) {
        hash[nums1[i]] = 1;
    }

    for (int i = 0; i < nums2Size; i++) {
        if (hash[nums2[i]] == 1) {
            hash[nums2[i]] = 0;
            result = (int*)realloc(result, (count + 1) * sizeof(int));
            result[count++] = nums2[i];
        }
    }

    *returnSize = count;
    return result;
}