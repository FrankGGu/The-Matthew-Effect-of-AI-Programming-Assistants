#include <stdlib.h>

int* intersect(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (nums1Size < nums2Size ? nums1Size : nums2Size));
    int index = 0;

    int hash[1001] = {0};

    for (int i = 0; i < nums1Size; i++) {
        hash[nums1[i]]++;
    }

    for (int i = 0; i < nums2Size; i++) {
        if (hash[nums2[i]] > 0) {
            result[index++] = nums2[i];
            hash[nums2[i]]--;
        }
    }

    *returnSize = index;
    return result;
}