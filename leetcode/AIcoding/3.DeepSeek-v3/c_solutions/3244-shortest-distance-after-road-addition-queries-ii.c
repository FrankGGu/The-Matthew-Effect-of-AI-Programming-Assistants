int* shortestDistanceAfterQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* res = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int* next = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        next[i] = i + 1;
    }

    int dist = n - 1;

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];

        if (next[u] < v) {
            int cur = u;
            while (next[cur] < v) {
                int nxt = next[cur];
                next[cur] = v;
                dist -= (nxt - cur - 1);
                cur = nxt;
            }
        }

        res[i] = dist;
    }

    free(next);
    return res;
}