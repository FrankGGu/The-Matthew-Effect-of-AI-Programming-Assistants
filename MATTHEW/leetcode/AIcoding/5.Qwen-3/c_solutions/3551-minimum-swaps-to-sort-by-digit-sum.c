#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int getDigitSum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int minimumSwapsToSortByDigitSum(int* nums, int numsSize) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }

    qsort(sorted, numsSize, sizeof(int), compare);

    int* indexMap = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indexMap[i] = i;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (getDigitSum(sorted[i]) > getDigitSum(sorted[j])) {
                int temp = sorted[i];
                sorted[i] = sorted[j];
                sorted[j] = temp;
            }
        }
    }

    int swaps = 0;
    for (int i = 0; i < numsSize; i++) {
        int j = i;
        while (indexMap[j] != i) {
            j = indexMap[j];
        }
        if (j != i) {
            indexMap[i] = indexMap[j];
            indexMap[j] = i;
            swaps++;
        }
    }

    free(sorted);
    free(indexMap);
    return swaps;
}