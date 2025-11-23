#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** findDifference(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize, int** returnColumnSizes) {
    bool inNums1[2001] = {false};
    bool inNums2[2001] = {false};

    for (int i = 0; i < nums1Size; i++) {
        inNums1[nums1[i] + 1000] = true;
    }

    for (int i = 0; i < nums2Size; i++) {
        inNums2[nums2[i] + 1000] = true;
    }

    int* list1 = (int*)malloc(nums1Size * sizeof(int));
    int* list2 = (int*)malloc(nums2Size * sizeof(int));
    int list1Size = 0;
    int list2Size = 0;

    for (int i = 0; i < nums1Size; i++) {
        if (!inNums2[nums1[i] + 1000]) {
            bool found = false;
            for (int j = 0; j < list1Size; j++) {
                if (list1[j] == nums1[i]) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                list1[list1Size++] = nums1[i];
            }
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        if (!inNums1[nums2[i] + 1000]) {
            bool found = false;
            for (int j = 0; j < list2Size; j++) {
                if (list2[j] == nums2[i]) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                list2[list2Size++] = nums2[i];
            }
        }
    }

    int** result = (int**)malloc(2 * sizeof(int*));
    result[0] = list1;
    result[1] = list2;

    *returnSize = 2;
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = list1Size;
    (*returnColumnSizes)[1] = list2Size;

    return result;
}