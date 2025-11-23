#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] != y[0]) return x[0] - y[0];
    return x[1] - y[1];
}

int lengthOfLIS(int* nums, int numsSize) {
    int* tails = (int*)malloc(numsSize * sizeof(int));
    int size = 0;
    for (int i = 0; i < numsSize; i++) {
        int left = 0, right = size;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (tails[mid] < nums[i])
                left = mid + 1;
            else
                right = mid;
        }
        tails[left] = nums[i];
        if (left == size) size++;
    }
    free(tails);
    return size;
}

int maxEnvelopes(int** envelopes, int envelopesSize, int* envelopesColSize) {
    qsort(envelopes, envelopesSize, sizeof(int*), compare);
    int* heights = (int*)malloc(envelopesSize * sizeof(int));
    for (int i = 0; i < envelopesSize; i++) {
        heights[i] = envelopes[i][1];
    }
    int result = lengthOfLIS(heights, envelopesSize);
    free(heights);
    return result;
}