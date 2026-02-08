int* checkIfPrerequisite(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int** reachable = (int**)malloc(numCourses * sizeof(int*));
    for (int i = 0; i < numCourses; i++) {
        reachable[i] = (int*)calloc(numCourses, sizeof(int));
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][0];
        int v = prerequisites[i][1];
        reachable[u][v] = 1;
    }

    for (int k = 0; k < numCourses; k++) {
        for (int i = 0; i < numCourses; i++) {
            for (int j = 0; j < numCourses; j++) {
                if (reachable[i][k] && reachable[k][j]) {
                    reachable[i][j] = 1;
                }
            }
        }
    }

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        result[i] = reachable[u][v];
    }

    for (int i = 0; i < numCourses; i++) {
        free(reachable[i]);
    }
    free(reachable);

    return result;
}