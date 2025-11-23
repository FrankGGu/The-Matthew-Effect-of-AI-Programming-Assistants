#include <stdlib.h>

typedef struct {
    int d;
    int p;
} Job;

int compareJobs(const void *a, const void *b) {
    Job *jobA = (Job *)a;
    Job *jobB = (Job *)b;
    return jobA->d - jobB->d;
}

int compareInts(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

long long maxProfitAssignment(int* difficulty, int difficultySize, int* profit, int profitSize, int* worker, int workerSize) {
    Job* jobs = (Job*)malloc(difficultySize * sizeof(Job));
    for (int i = 0; i < difficultySize; i++) {
        jobs[i].d = difficulty[i];
        jobs[i].p = profit[i];
    }

    qsort(jobs, difficultySize, sizeof(Job), compareJobs);
    qsort(worker, workerSize, sizeof(int), compareInts);

    long long totalProfit = 0;
    int currentMaxProfit = 0;
    int jobIdx = 0;

    for (int i = 0; i < workerSize; i++) {
        int workerAbility = worker[i];

        while (jobIdx < difficultySize && jobs[jobIdx].d <= workerAbility) {
            currentMaxProfit = max(currentMaxProfit, jobs[jobIdx].p);
            jobIdx++;
        }

        totalProfit += currentMaxProfit;
    }

    free(jobs);

    return totalProfit;
}