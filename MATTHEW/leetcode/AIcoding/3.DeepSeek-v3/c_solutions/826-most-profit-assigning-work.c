#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maxProfitAssignment(int* difficulty, int difficultySize, int* profit, int profitSize, int* worker, int workerSize) {
    int jobs[difficultySize][2];
    for (int i = 0; i < difficultySize; i++) {
        jobs[i][0] = difficulty[i];
        jobs[i][1] = profit[i];
    }

    qsort(jobs, difficultySize, sizeof(jobs[0]), cmp);
    qsort(worker, workerSize, sizeof(int), cmp);

    int maxProfit = 0, best = 0, j = 0;
    for (int i = 0; i < workerSize; i++) {
        while (j < difficultySize && worker[i] >= jobs[j][0]) {
            if (jobs[j][1] > best) {
                best = jobs[j][1];
            }
            j++;
        }
        maxProfit += best;
    }

    return maxProfit;
}