typedef struct {
    int x;
    int y;
    int idx;
} Query;

int cmp(const void* a, const void* b) {
    Query* q1 = (Query*)a;
    Query* q2 = (Query*)b;
    int d1 = abs(q1->x) + abs(q1->y);
    int d2 = abs(q2->x) + abs(q2->y);
    return d1 - d2;
}

int* resultsArray(int** obstacles, int obstaclesSize, int* obstaclesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* res = malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    Query* sortedQueries = malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i].x = queries[i][0];
        sortedQueries[i].y = queries[i][1];
        sortedQueries[i].idx = i;
    }

    qsort(sortedQueries, queriesSize, sizeof(Query), cmp);

    int* dists = malloc(obstaclesSize * sizeof(int));
    for (int i = 0; i < obstaclesSize; i++) {
        dists[i] = abs(obstacles[i][0]) + abs(obstacles[i][1]);
    }

    qsort(dists, obstaclesSize, sizeof(int), cmp);

    int j = 0;
    for (int i = 0; i < queriesSize; i++) {
        int d = abs(sortedQueries[i].x) + abs(sortedQueries[i].y);
        while (j < obstaclesSize && dists[j] <= d) {
            j++;
        }
        res[sortedQueries[i].idx] = j;
    }

    free(sortedQueries);
    free(dists);
    return res;
}