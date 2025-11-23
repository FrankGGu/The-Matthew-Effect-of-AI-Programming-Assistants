#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* intersection(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize){
    int *result = (int*)malloc(sizeof(int) * (nums1Size > nums2Size ? nums2Size : nums1Size));
    int result_index = 0;
    int i, j;
    int found;

    for (i = 0; i < nums1Size; i++) {
        found = 0;
        for (j = 0; j < nums2Size; j++) {
            if (nums1[i] == nums2[j]) {
                int k;
                int already_exists = 0;
                for (k = 0; k < result_index; k++) {
                    if (result[k] == nums1[i]) {
                        already_exists = 1;
                        break;
                    }
                }
                if (!already_exists) {
                    result[result_index++] = nums1[i];
                }
                found = 1;
                break;
            }
        }
    }

    *returnSize = result_index;
    return result;
}