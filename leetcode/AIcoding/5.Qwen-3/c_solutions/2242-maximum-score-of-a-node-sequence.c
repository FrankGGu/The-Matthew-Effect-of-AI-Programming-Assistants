#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* neighbors;
    int size;
} AdjList;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maxScore(int** times, int n, int m) {
    int* scores = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        scores[i] = 0;
    }

    for (int i = 0; i < m; i++) {
        int u = times[i][0];
        int v = times[i][1];
        int t = times[i][2];
        scores[u] += t;
        scores[v] += t;
    }

    qsort(scores, n, sizeof(int), compare);

    int total = 0;
    for (int i = 0; i < 3; i++) {
        total += scores[n - 1 - i];
    }

    free(scores);
    return total;
}

int maxScoreOfNodeSequence(int** times, int n, int m) {
    return maxScore(times, n, m);
}