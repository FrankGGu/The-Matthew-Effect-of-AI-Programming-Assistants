#include <stdlib.h>
#include <string.h>

int** findMatrix(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int* freq = (int*)calloc(numsSize + 1, sizeof(int));
    if (freq == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int max_freq = 0;
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > max_freq) {
            max_freq = freq[nums[i]];
        }
    }

    *returnSize = max_freq;

    int** result = (int**)malloc(max_freq * sizeof(int*));
    if (result == NULL) {
        free(freq);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    *returnColumnSizes = (int*)malloc(max_freq * sizeof(int));
    if (*returnColumnSizes == NULL) {
        free(freq);
        free(result);
        *returnSize = 0;
        return NULL;
    }

    int* row_fill_counts = (int*)calloc(max_freq, sizeof(int));
    if (row_fill_counts == NULL) {
        free(freq);
        free(result);
        free(*returnColumnSizes);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < max_freq; i++) {
        result[i] = (int*)malloc(numsSize * sizeof(int));
        if (result[i] == NULL) {
            for (int j = 0; j < i; j++) {
                free(result[j]);
            }
            free(result);
            free(freq);
            free(*returnColumnSizes);
            free(row_fill_counts);
            *returnSize = 0;
            return NULL;
        }
    }

    int* current_row_idx = (int*)calloc(numsSize + 1, sizeof(int));
    if (current_row_idx == NULL) {
        for (int i = 0; i < max_freq; i++) {
            free(result[i]);
        }
        free(result);
        free(freq);
        free(*returnColumnSizes);
        free(row_fill_counts);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int target_row = current_row_idx[num];

        result[target_row][row_fill_counts[target_row]] = num;
        row_fill_counts[target_row]++;
        current_row_idx[num]++;
    }

    for (int i = 0; i < max_freq; i++) {
        (*returnColumnSizes)[i] = row_fill_counts[i];
        result[i] = (int*)realloc(result[i], row_fill_counts[i] * sizeof(int));
    }

    free(freq);
    free(current_row_idx);
    free(row_fill_counts);

    return result;
}