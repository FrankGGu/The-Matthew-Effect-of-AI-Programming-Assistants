#include <stdio.h>
#include <stdlib.h>

int* twoOutOfThree(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* returnSize) {
    int* hash = (int*)calloc(101, sizeof(int));
    int* result = NULL;
    int count = 0;

    for (int i = 0; i < nums1Size; i++) {
        hash[nums1[i]] |= 1;
    }

    for (int i = 0; i < nums2Size; i++) {
        hash[nums2[i]] |= 2;
    }

    for (int i = 0; i < nums3Size; i++) {
        hash[nums3[i]] |= 4;
    }

    for (int i = 0; i <= 100; i++) {
        if (hash[i] & hash[i] - 1) {
            count++;
        }
    }

    result = (int*)malloc(count * sizeof(int));
    count = 0;

    for (int i = 0; i <= 100; i++) {
        if (hash[i] & hash[i] - 1) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    free(hash);
    return result;
}