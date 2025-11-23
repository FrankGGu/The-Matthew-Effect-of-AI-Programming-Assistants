#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

char **findRelativeRanks(char **score, int scoreSize, int *returnSize) {
    int *nums = (int *)malloc(sizeof(int) * scoreSize);
    for (int i = 0; i < scoreSize; i++) {
        nums[i] = atoi(score[i]);
    }

    int *sorted_nums = (int *)malloc(sizeof(int) * scoreSize);
    memcpy(sorted_nums, nums, sizeof(int) * scoreSize);
    qsort(sorted_nums, scoreSize, sizeof(int), compare);

    char **result = (char **)malloc(sizeof(char *) * scoreSize);
    for (int i = 0; i < scoreSize; i++) {
        result[i] = (char *)malloc(sizeof(char) * 20);
    }

    for (int i = 0; i < scoreSize; i++) {
        int rank = scoreSize;
        for (int j = 0; j < scoreSize; j++) {
            if (nums[i] < sorted_nums[j]) {
                rank--;
            }
        }

        if (rank == 1) {
            strcpy(result[i], "Gold Medal");
        } else if (rank == 2) {
            strcpy(result[i], "Silver Medal");
        } else if (rank == 3) {
            strcpy(result[i], "Bronze Medal");
        } else {
            sprintf(result[i], "%d", rank);
        }
    }

    free(nums);
    free(sorted_nums);

    *returnSize = scoreSize;
    return result;
}