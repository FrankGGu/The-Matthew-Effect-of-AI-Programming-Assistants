#include <stdlib.h>

int compareAsc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int compareDesc(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int* sortEvenOdd(int* nums, int numsSize, int* returnSize) {
    if (numsSize <= 1) {
        *returnSize = numsSize;
        return nums;
    }

    int evenCount = (numsSize + 1) / 2;
    int oddCount = numsSize / 2;

    int* evenElements = (int*)malloc(evenCount * sizeof(int));
    int* oddElements = (int*)malloc(oddCount * sizeof(int));

    int currentEven = 0;
    int currentOdd = 0;

    for (int i = 0; i < numsSize; ++i) {
        if (i % 2 == 0) { // Even index
            evenElements[currentEven++] = nums[i];
        } else { // Odd index
            oddElements[currentOdd++] = nums[i];
        }
    }

    qsort(evenElements, evenCount, sizeof(int), compareAsc);
    qsort(oddElements, oddCount, sizeof(int), compareDesc);

    currentEven = 0;
    currentOdd = 0;

    for (int i = 0; i < numsSize; ++i) {
        if (i % 2 == 0) {
            nums[i] = evenElements[currentEven++];
        } else {
            nums[i] = oddElements[currentOdd++];
        }
    }

    free(evenElements);
    free(oddElements);

    *returnSize = numsSize;
    return nums;
}