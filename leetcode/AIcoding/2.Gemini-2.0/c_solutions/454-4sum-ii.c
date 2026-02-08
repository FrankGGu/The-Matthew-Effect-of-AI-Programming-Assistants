#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int fourSumCount(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* nums4, int nums4Size) {
    int count = 0;
    int sum;
    int hash_size = 40000;
    int offset = 20000;
    int* hash = (int*)calloc(hash_size, sizeof(int));

    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            sum = nums1[i] + nums2[j];
            hash[sum + offset]++;
        }
    }

    for (int i = 0; i < nums3Size; i++) {
        for (int j = 0; j < nums4Size; j++) {
            sum = nums3[i] + nums4[j];
            count += hash[-sum + offset];
        }
    }

    free(hash);
    return count;
}