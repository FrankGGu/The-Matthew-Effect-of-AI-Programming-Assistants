#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size){
    int sum1 = 0, sum2 = 0;
    for (int i = 0; i < nums1Size; i++) {
        sum1 += nums1[i];
    }
    for (int i = 0; i < nums2Size; i++) {
        sum2 += nums2[i];
    }

    if ((nums1Size > nums2Size * 6) || (nums2Size > nums1Size * 6)) {
        return -1;
    }

    if (sum1 == sum2) {
        return 0;
    }

    if (sum1 > sum2) {
        int* temp = nums1;
        nums1 = nums2;
        nums2 = temp;
        int tempSize = nums1Size;
        nums1Size = nums2Size;
        nums2Size = tempSize;
        int tempSum = sum1;
        sum1 = sum2;
        sum2 = tempSum;
    }

    int diff = sum2 - sum1;
    int count = 0;
    int* diff1 = (int*)malloc(sizeof(int) * nums1Size);
    int* diff2 = (int*)malloc(sizeof(int) * nums2Size);
    for (int i = 0; i < nums1Size; i++) {
        diff1[i] = 6 - nums1[i];
    }
    for (int i = 0; i < nums2Size; i++) {
        diff2[i] = nums2[i] - 1;
    }

    int* combined = (int*)malloc(sizeof(int) * (nums1Size + nums2Size));
    int combinedSize = 0;
    for (int i = 0; i < nums1Size; i++) {
        combined[combinedSize++] = diff1[i];
    }
    for (int i = 0; i < nums2Size; i++) {
        combined[combinedSize++] = diff2[i];
    }

    qsort(combined, combinedSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

    for (int i = combinedSize - 1; i >= 0; i--) {
        diff -= combined[i];
        count++;
        if (diff <= 0) {
            free(diff1);
            free(diff2);
            free(combined);
            return count;
        }
    }

    free(diff1);
    free(diff2);
    free(combined);
    return -1;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}