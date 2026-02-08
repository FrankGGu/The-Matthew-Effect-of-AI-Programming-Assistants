#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int maxProfitAssignment(int* difficulty, int difficultySize, int* profit, int profitSize, int* worker, int workerSize) {
    int jobs[difficultySize][2];
    for (int i = 0; i < difficultySize; i++) {
        jobs[i][0] = difficulty[i];
        jobs[i][1] = profit[i];
    }

    qsort(jobs, difficultySize, sizeof(jobs[0]), cmp);
    qsort(worker, workerSize, sizeof(int), cmp);

    int max_profit = 0;
    int best_profit = 0;
    int j = 0;
    for (int i = 0; i < workerSize; i++) {
        while (j < difficultySize && jobs[j][0] <= worker[i]) {
            if (jobs[j][1] > best_profit) {
                best_profit = jobs[j][1];
            }
            j++;
        }
        max_profit += best_profit;
    }

    return max_profit;
}