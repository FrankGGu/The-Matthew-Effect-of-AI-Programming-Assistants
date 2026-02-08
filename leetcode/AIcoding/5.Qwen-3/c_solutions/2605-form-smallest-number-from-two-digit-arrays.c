#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minNumber(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int count[10] = {0};
    for (int i = 0; i < nums1Size; i++) {
        count[nums1[i]]++;
    }
    for (int i = 0; i < nums2Size; i++) {
        count[nums2[i]]++;
    }

    char* result = (char*)malloc(11 * sizeof(char));
    int index = 0;
    for (int i = 0; i < 10; i++) {
        if (count[i] > 0) {
            result[index++] = i + '0';
        }
    }
    result[index] = '\0';
    return result;
}