#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* sequentialDigits(int low, int high, int* returnSize) {
    int* result = (int*)malloc(36 * sizeof(int)); // Maximum possible sequential digits is 36
    *returnSize = 0;

    for (int i = 1; i <= 9; ++i) { // Starting digit
        long long num = i; 
        for (int j = i + 1; j <= 9; ++j) { // Subsequent digits
            num = num * 10 + j;
            if (num > high) { // Optimization: if current number exceeds high, further extensions will also exceed high
                break;
            }
            if (num >= low) {
                result[*returnSize] = (int)num;
                (*returnSize)++;
            }
        }
    }

    qsort(result, *returnSize, sizeof(int), compare);

    // Reallocate to the exact size
    int* finalResult = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; ++i) {
        finalResult[i] = result[i];
    }
    free(result); 

    return finalResult;
}