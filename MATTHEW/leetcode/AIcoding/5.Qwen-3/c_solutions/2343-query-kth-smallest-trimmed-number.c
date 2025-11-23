#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* str;
    int index;
} TrimmedString;

int compare(const void* a, const void* b) {
    TrimmedString* x = (TrimmedString*)a;
    TrimmedString* y = (TrimmedString*)b;
    return strcmp(x->str, y->str);
}

int* querySmallestTrimmedNumbers(char** nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        result[i] = i;
    }

    TrimmedString* trimmed = (TrimmedString*)malloc(numsSize * sizeof(TrimmedString));

    for (int i = 0; i < numsSize; i++) {
        trimmed[i].str = (char*)malloc((strlen(nums[i]) - k + 1) * sizeof(char));
        strncpy(trimmed[i].str, nums[i] + k, strlen(nums[i]) - k);
        trimmed[i].str[strlen(nums[i]) - k] = '\0';
        trimmed[i].index = i;
    }

    qsort(trimmed, numsSize, sizeof(TrimmedString), compare);

    for (int i = 0; i < numsSize; i++) {
        result[i] = trimmed[i].index;
    }

    for (int i = 0; i < numsSize; i++) {
        free(trimmed[i].str);
    }

    free(trimmed);

    return result;
}