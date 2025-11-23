#include <stdio.h>
#include <stdlib.h>

int* twoOutOfThree(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* returnSize) {
    int count[101] = {0};
    int* result = (int*)malloc(101 * sizeof(int));
    int index = 0;

    for (int i = 0; i < nums1Size; i++) count[nums1[i]] = 1;
    for (int i = 0; i < nums2Size; i++) if (count[nums2[i]] == 1) count[nums2[i]] = 2;
    for (int i = 0; i < nums3Size; i++) if (count[nums3[i]] == 1) count[nums3[i]] = 2;
    for (int i = 0; i < nums3Size; i++) if (count[nums3[i]] == 2) count[nums3[i]] = 3;

    for (int i = 0; i < 101; i++) {
        if (count[i] == 2 || count[i] == 3) {
            result[index++] = i;
        }
    }

    *returnSize = index;
    return result;
}