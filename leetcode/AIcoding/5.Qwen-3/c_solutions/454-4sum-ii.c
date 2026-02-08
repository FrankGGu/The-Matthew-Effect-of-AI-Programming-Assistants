#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int fourSumCount(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* nums4, int nums4Size) {
    int count = 0;
    int* sum12 = (int*)malloc(nums1Size * nums2Size * sizeof(int));
    int index = 0;

    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            sum12[index++] = nums1[i] + nums2[j];
        }
    }

    qsort(sum12, index, sizeof(int), compare);

    for (int k = 0; k < nums3Size; k++) {
        for (int l = 0; l < nums4Size; l++) {
            int target = -(nums3[k] + nums4[l]);
            int left = 0;
            int right = index - 1;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (sum12[mid] == target) {
                    count++;
                    break;
                } else if (sum12[mid] < target) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
    }

    free(sum12);
    return count;
}