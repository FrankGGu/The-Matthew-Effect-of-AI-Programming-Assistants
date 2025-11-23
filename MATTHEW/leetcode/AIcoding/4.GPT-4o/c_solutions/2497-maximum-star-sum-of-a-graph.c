int maxStarSum(int* vals, int valsSize, int** edges, int edgesSize, int* edgesColSize, int k) {
    int max_sum = 0;
    int* adj = (int*)calloc(valsSize, sizeof(int*));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u]++;
        adj[v]++;
    }

    for (int i = 0; i < valsSize; i++) {
        if (vals[i] > 0) {
            max_sum += vals[i];
            int count = 0;
            int* temp = (int*)malloc(adj[i] * sizeof(int));
            for (int j = 0; j < edgesSize; j++) {
                if (edges[j][0] == i) {
                    temp[count++] = vals[edges[j][1]];
                } else if (edges[j][1] == i) {
                    temp[count++] = vals[edges[j][0]];
                }
            }
            qsort(temp, count, sizeof(int), cmp);
            for (int j = 0; j < count && j < k; j++) {
                if (temp[j] > 0) {
                    max_sum += temp[j];
                }
            }
            free(temp);
        }
    }
    free(adj);
    return max_sum;
}

int cmp(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}