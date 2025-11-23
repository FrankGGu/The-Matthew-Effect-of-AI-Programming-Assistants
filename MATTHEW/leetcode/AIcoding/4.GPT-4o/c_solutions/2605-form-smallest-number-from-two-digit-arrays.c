#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b;
}

char* minNumber(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int nums[10] = {0};
    for (int i = 0; i < nums1Size; i++) {
        nums[nums1[i]] = 1;
    }
    for (int i = 0; i < nums2Size; i++) {
        nums[nums2[i]] = 1;
    }

    char* result = (char*)malloc(11 * sizeof(char));
    int index = 0;

    for (int i = 0; i < 10; i++) {
        if (nums[i]) {
            result[index++] = '0' + i;
        }
    }
    result[index] = '\0';

    if (result[0] == '0') {
        return result;
    }

    return result;
}