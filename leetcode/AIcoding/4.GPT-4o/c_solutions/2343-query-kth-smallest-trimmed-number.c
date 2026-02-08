#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int index;
    char *value;
} Number;

int compare(const void *a, const void *b) {
    Number *num1 = (Number *)a;
    Number *num2 = (Number *)b;
    return strcmp(num1->value, num2->value);
}

char *trim(char *s, int k) {
    int len = strlen(s);
    s[len - k] = '\0';
    return s + len - k;
}

int* smallestTrimmedNumbers(char **nums, int numsSize, int **queries, int queriesSize, int *returnSize) {
    *returnSize = queriesSize;
    int *result = (int *)malloc(sizeof(int) * queriesSize);
    Number *numberArray = (Number *)malloc(sizeof(Number) * numsSize);

    for (int i = 0; i < numsSize; i++) {
        numberArray[i].index = i;
        numberArray[i].value = nums[i];
    }

    for (int i = 0; i < queriesSize; i++) {
        int k = queries[i][1];
        int trimLength = queries[i][0];

        for (int j = 0; j < numsSize; j++) {
            numberArray[j].value = trim(strdup(nums[j]), trimLength);
        }

        qsort(numberArray, numsSize, sizeof(Number), compare);
        result[i] = numberArray[k - 1].index;

        for (int j = 0; j < numsSize; j++) {
            numberArray[j].value = nums[j]; // Restore original values for next query
        }
    }

    free(numberArray);
    return result;
}