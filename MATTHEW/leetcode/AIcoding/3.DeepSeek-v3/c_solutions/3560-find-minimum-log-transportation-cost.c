#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

long long minCost(int* logs, int logsSize, int k) {
    if (logsSize == 0) return 0;

    qsort(logs, logsSize, sizeof(int), cmp);

    long long total = 0;
    int cuts = logsSize - 1;
    int needed_cuts = (logsSize - 1 + k - 1) / k;

    int* diff = (int*)malloc(cuts * sizeof(int));
    for (int i = 0; i < cuts; i++) {
        diff[i] = logs[i + 1] - logs[i];
    }

    qsort(diff, cuts, sizeof(int), cmp);

    for (int i = 0; i < cuts - needed_cuts; i++) {
        total += diff[i];
    }

    free(diff);
    return total;
}