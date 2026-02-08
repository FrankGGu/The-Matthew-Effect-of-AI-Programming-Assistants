#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* twoOutOfThree(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* returnSize){
    int counts[101] = {0};
    int* result = (int*)malloc(sizeof(int) * 300);
    *returnSize = 0;

    for (int i = 0; i < nums1Size; i++) {
        counts[nums1[i]] |= 1;
    }
    for (int i = 0; i < nums2Size; i++) {
        counts[nums2[i]] |= 2;
    }
    for (int i = 0; i < nums3Size; i++) {
        counts[nums3[i]] |= 4;
    }

    for (int i = 1; i <= 100; i++) {
        if (counts[i] == 3 || counts[i] == 5 || counts[i] == 6 || counts[i] == 7) {
            result[*returnSize] = i;
            (*returnSize)++;
        }
    }

    return result;
}