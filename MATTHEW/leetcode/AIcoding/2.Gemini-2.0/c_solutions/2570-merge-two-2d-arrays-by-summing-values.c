#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** mergeArrays(int** nums1, int nums1Size, int* nums1ColSize, int** nums2, int nums2Size, int* nums2ColSize, int* returnSize, int** returnColumnSizes) {
    int i = 0, j = 0, k = 0;
    int** result = (int**)malloc(sizeof(int*) * (nums1Size + nums2Size));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (nums1Size + nums2Size));

    while (i < nums1Size && j < nums2Size) {
        result[k] = (int*)malloc(sizeof(int) * 2);
        (*returnColumnSizes)[k] = 2;
        if (nums1[i][0] < nums2[j][0]) {
            result[k][0] = nums1[i][0];
            result[k][1] = nums1[i][1];
            i++;
        } else if (nums1[i][0] > nums2[j][0]) {
            result[k][0] = nums2[j][0];
            result[k][1] = nums2[j][1];
            j++;
        } else {
            result[k][0] = nums1[i][0];
            result[k][1] = nums1[i][1] + nums2[j][1];
            i++;
            j++;
        }
        k++;
    }

    while (i < nums1Size) {
        result[k] = (int*)malloc(sizeof(int) * 2);
        (*returnColumnSizes)[k] = 2;
        result[k][0] = nums1[i][0];
        result[k][1] = nums1[i][1];
        i++;
        k++;
    }

    while (j < nums2Size) {
        result[k] = (int*)malloc(sizeof(int) * 2);
        (*returnColumnSizes)[k] = 2;
        result[k][0] = nums2[j][0];
        result[k][1] = nums2[j][1];
        j++;
        k++;
    }

    *returnSize = k;
    return result;
}