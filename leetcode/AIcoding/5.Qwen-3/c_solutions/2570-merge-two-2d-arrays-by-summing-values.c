#include <stdio.h>
#include <stdlib.h>

int** mergeArrays(int** nums1, int nums1Size, int* nums1ColSize, int** nums2, int nums2Size, int* nums2ColSize, int* returnSize, int** returnColumnSizes) {
    int maxKey = 0;
    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i][0] > maxKey) maxKey = nums1[i][0];
    }
    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i][0] > maxKey) maxKey = nums2[i][0];
    }

    int* sum = (int*)calloc(maxKey + 1, sizeof(int));
    int count = 0;

    for (int i = 0; i < nums1Size; i++) {
        sum[nums1[i][0]] += nums1[i][1];
        if (nums1[i][1] != 0) count++;
    }

    for (int i = 0; i < nums2Size; i++) {
        sum[nums2[i][0]] += nums2[i][1];
        if (nums2[i][1] != 0) count++;
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    int index = 0;
    for (int i = 0; i <= maxKey; i++) {
        if (sum[i] != 0) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = i;
            result[index][1] = sum[i];
            (*returnColumnSizes)[index] = 2;
            index++;
        }
    }

    free(sum);
    return result;
}