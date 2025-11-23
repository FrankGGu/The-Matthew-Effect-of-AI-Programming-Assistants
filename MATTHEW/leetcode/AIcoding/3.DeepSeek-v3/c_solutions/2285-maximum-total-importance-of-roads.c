int cmp(const void* a, const void* b) {
    return *(long long*)b - *(long long*)a;
}

long long maximumImportance(int n, int** roads, int roadsSize, int* roadsColSize) {
    int* degree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < roadsSize; i++) {
        degree[roads[i][0]]++;
        degree[roads[i][1]]++;
    }

    long long* deg = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        deg[i] = degree[i];
    }

    qsort(deg, n, sizeof(long long), cmp);

    long long result = 0;
    for (int i = 0; i < n; i++) {
        result += deg[i] * (n - i);
    }

    free(degree);
    free(deg);
    return result;
}