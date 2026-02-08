#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findMedian(int* nums, int n) {
    int* copy = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) copy[i] = nums[i];
    qsort(copy, n, sizeof(int), compare);
    int median = copy[n / 2];
    free(copy);
    return median;
}

int countSubarraysWithMedianK(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == k) {
            count++;
            int left = i - 1;
            int right = i + 1;
            while (left >= 0 || right < numsSize) {
                int* sub = (int*)malloc((right - left + 1) * sizeof(int));
                int idx = 0;
                for (int j = left; j <= right; j++) {
                    sub[idx++] = nums[j];
                }
                int median = findMedian(sub, idx);
                if (median == k) count++;
                free(sub);
                if (left >= 0) left--;
                if (right < numsSize) right++;
            }
        }
    }
    return count;
}