int findChampion(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* indegree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        indegree[v]++;
    }

    int champion = -1;
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            champion = i;
            count++;
        }
    }

    free(indegree);

    if (count == 1) {
        return champion;
    } else {
        return -1;
    }
}