#include <stdlib.h>

int* colorTheArray(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* nums = (int*)calloc(n, sizeof(int));

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int current_same_color_pairs = 0;
    if (n > 0) { // n is guaranteed to be >= 1 by constraints
        current_same_color_pairs = n - 1;
    }

    for (int i = 0; i < queriesSize; ++i) {
        int idx = queries[i][0];
        int new_color = queries[i][1];
        int old_color = nums[idx];

        if (idx > 0) {
            if (nums[idx - 1] == old_color) {
                current_same_color_pairs--;
            }
        }
        if (idx < n - 1) {
            if (nums[idx + 1] == old_color) {
                current_same_color_pairs--;
            }
        }

        nums[idx] = new_color;

        if (idx > 0) {
            if (nums[idx - 1] == new_color) {
                current_same_color_pairs++;
            }
        }
        if (idx < n - 1) {
            if (nums[idx + 1] == new_color) {
                current_same_color_pairs++;
            }
        }

        result[i] = current_same_color_pairs;
    }

    free(nums);

    return result;
}