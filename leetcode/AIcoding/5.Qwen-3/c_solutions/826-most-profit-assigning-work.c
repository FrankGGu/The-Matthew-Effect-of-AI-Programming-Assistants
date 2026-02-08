#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* maxProfitAssignment(int* difficulty, int difficultySize, int* profit, int profitSize, int* worker, int workerSize, int* returnSize) {
    int i;
    int* result = (int*)malloc(workerSize * sizeof(int));
    int* sortedProfit = (int*)malloc(difficultySize * sizeof(int));
    int* sortedDifficulty = (int*)malloc(difficultySize * sizeof(int));

    for (i = 0; i < difficultySize; i++) {
        sortedDifficulty[i] = difficulty[i];
        sortedProfit[i] = profit[i];
    }

    qsort(sortedDifficulty, difficultySize, sizeof(int), compare);

    for (i = 1; i < difficultySize; i++) {
        if (sortedProfit[i] < sortedProfit[i - 1]) {
            sortedProfit[i] = sortedProfit[i - 1];
        }
    }

    for (i = 0; i < workerSize; i++) {
        int left = 0;
        int right = difficultySize - 1;
        int best = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sortedDifficulty[mid] <= worker[i]) {
                best = sortedProfit[mid];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        result[i] = best;
    }

    *returnSize = workerSize;
    return result;
}