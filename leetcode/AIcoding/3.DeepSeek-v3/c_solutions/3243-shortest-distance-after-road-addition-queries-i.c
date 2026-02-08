int* shortestDistanceAfterQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* dist = (int*)malloc(n * sizeof(int));
    int* res = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];

        for (int j = 0; j < n; j++) {
            dist[j] = j;
        }

        for (int j = 0; j <= i; j++) {
            int from = queries[j][0];
            int to = queries[j][1];
            if (dist[to] > dist[from] + 1) {
                dist[to] = dist[from] + 1;
                for (int k = to + 1; k < n; k++) {
                    if (dist[k] > dist[k-1] + 1) {
                        dist[k] = dist[k-1] + 1;
                    } else {
                        break;
                    }
                }
            }
        }

        res[i] = dist[n-1];
    }

    free(dist);
    return res;
}