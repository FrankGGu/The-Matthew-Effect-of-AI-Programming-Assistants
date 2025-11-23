#include <stdio.h>
#include <stdlib.h>

int minMaxGame(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int* arr1 = (int*)malloc(nums1Size * sizeof(int));
    int* arr2 = (int*)malloc(nums2Size * sizeof(int));
    for (int i = 0; i < nums1Size; i++) {
        arr1[i] = nums1[i];
    }
    for (int i = 0; i < nums2Size; i++) {
        arr2[i] = nums2[i];
    }

    while (nums1Size > 1) {
        int new_size = 0;
        for (int i = 0; i < nums1Size; i += 2) {
            arr1[new_size++] = (arr1[i] > arr1[i + 1]) ? arr1[i] : arr1[i + 1];
        }
        nums1Size = new_size;
    }

    while (nums2Size > 1) {
        int new_size = 0;
        for (int i = 0; i < nums2Size; i += 2) {
            arr2[new_size++] = (arr2[i] > arr2[i + 1]) ? arr2[i] : arr2[i + 1];
        }
        nums2Size = new_size;
    }

    int max1 = arr1[0];
    int max2 = arr2[0];
    free(arr1);
    free(arr2);
    return (max1 > max2) ? max1 : max2;
}