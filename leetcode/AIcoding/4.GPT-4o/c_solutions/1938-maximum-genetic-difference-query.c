#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *data;
    int size;
} Array;

typedef struct {
    Array *arrays;
    int size;
} Query;

int compare(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int maximumGeneticDifference(int** queries, int queriesSize, int* queriesColSize, int* nums, int numsSize) {
    int *result = (int *)malloc(queriesSize * sizeof(int));
    qsort(nums, numsSize, sizeof(int), compare);

    for (int i = 0; i < queriesSize; i++) {
        int num1 = queries[i][0];
        int num2 = queries[i][1];
        int min_val = num1 < num2 ? num1 : num2;
        int max_val = num1 > num2 ? num1 : num2;

        int left = 0, right = numsSize - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] < min_val) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int min_idx = left;

        left = 0, right = numsSize - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] <= max_val) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int max_idx = left;

        int max_diff = 0;
        for (int j = min_idx; j < max_idx; j++) {
            for (int k = j + 1; k < max_idx; k++) {
                int diff = nums[k] ^ nums[j];
                if (diff > max_diff) {
                    max_diff = diff;
                }
            }
        }
        result[i] = max_diff;
    }

    return result;
}