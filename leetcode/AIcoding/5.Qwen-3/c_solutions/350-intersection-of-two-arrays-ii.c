#include <stdio.h>
#include <stdlib.h>

int* intersect(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int hash[1001] = {0};
    int i;
    for (i = 0; i < nums1Size; i++) {
        hash[nums1[i]]++;
    }
    int count = 0;
    for (i = 0; i < nums2Size; i++) {
        if (hash[nums2[i]] > 0) {
            hash[nums2[i]]--;
            count++;
        }
    }
    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;
    for (i = 0; i < nums2Size; i++) {
        if (hash[nums2[i]] < 0) {
            result[index++] = nums2[i];
            hash[nums2[i]]++;
        }
    }
    *returnSize = count;
    return result;
}