/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int size;
    int right;
} Interval;

typedef struct {
    int val;
    int idx;
} Query;

int cmpIntervals(const void* a, const void* b) {
    Interval* i1 = (Interval*)a;
    Interval* i2 = (Interval*)b;
    return i1->size - i2->size;
}

int cmpQueries(const void* a, const void* b) {
    Query* q1 = (Query*)a;
    Query* q2 = (Query*)b;
    return q1->val - q2->val;
}

int* minInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* queries, int queriesSize, int* returnSize) {
    Interval* sortedIntervals = malloc(intervalsSize * sizeof(Interval));
    for (int i = 0; i < intervalsSize; i++) {
        sortedIntervals[i].size = intervals[i][1] - intervals[i][0] + 1;
        sortedIntervals[i].right = intervals[i][1];
    }

    qsort(sortedIntervals, intervalsSize, sizeof(Interval), cmpIntervals);

    Query* sortedQueries = malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i].val = queries[i];
        sortedQueries[i].idx = i;
    }

    qsort(sortedQueries, queriesSize, sizeof(Query), cmpQueries);

    int* result = malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = -1;
    }

    int* parent = malloc((queriesSize + 1) * sizeof(int));
    for (int i = 0; i <= queriesSize; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < intervalsSize; i++) {
        int size = sortedIntervals[i].size;
        int right = sortedIntervals[i].right;

        Query key = { .val = right + 1 };
        Query* ptr = bsearch(&key, sortedQueries, queriesSize, sizeof(Query), cmpQueries);
        int start;
        if (ptr == NULL) {
            start = queriesSize;
        } else {
            start = ptr - sortedQueries;
        }

        key.val = right - size + 1;
        ptr = bsearch(&key, sortedQueries, queriesSize, sizeof(Query), cmpQueries);
        int leftIdx;
        if (ptr == NULL) {
            leftIdx = 0;
        } else {
            leftIdx = ptr - sortedQueries;
        }

        int current = leftIdx;
        while (current < start) {
            if (result[sortedQueries[current].idx] == -1) {
                result[sortedQueries[current].idx] = size;
                parent[current] = current + 1;
            }
            current = parent[current];
        }
    }

    free(sortedIntervals);
    free(sortedQueries);
    free(parent);

    *returnSize = queriesSize;
    return result;
}