int maxEmployees(int** relations, int relationsSize, int* relationsColSize) {
    int n = relationsSize;
    int *indegree = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < relationsColSize[i]; j++) {
            indegree[relations[i][j]]++;
        }
    }

    int maxCount = 0;
    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            maxCount++;
        }
    }

    free(indegree);
    return maxCount;
}