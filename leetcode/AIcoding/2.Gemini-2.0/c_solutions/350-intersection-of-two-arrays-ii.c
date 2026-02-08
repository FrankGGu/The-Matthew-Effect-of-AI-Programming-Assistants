#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* intersect(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize){
    int *result = (int*)malloc(sizeof(int) * (nums1Size < nums2Size ? nums1Size : nums2Size));
    *returnSize = 0;

    int freq1[1001] = {0};
    int freq2[1001] = {0};

    for (int i = 0; i < nums1Size; i++) {
        freq1[nums1[i]]++;
    }

    for (int i = 0; i < nums2Size; i++) {
        freq2[nums2[i]]++;
    }

    for (int i = 0; i <= 1000; i++) {
        int count = (freq1[i] < freq2[i] ? freq1[i] : freq2[i]);
        for (int j = 0; j < count; j++) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}