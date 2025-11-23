int maximumInvitations(int** favorite, int favoriteSize, int* favoriteColSize) {
    int n = favoriteSize;
    int* inDegree = (int*)calloc(n, sizeof(int));
    int* outDegree = (int*)calloc(n, sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)calloc(n, sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        if (favorite[i][0] != -1) {
            graph[i][favorite[i][0]] = 1;
            outDegree[i]++;
            inDegree[favorite[i][0]]++;
        }
    }

    int maxInvitations = 0;

    for (int i = 0; i < n; i++) {
        if (outDegree[i] == 0) {
            maxInvitations++;
        }
    }

    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            maxInvitations++;
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(inDegree);
    free(outDegree);

    return maxInvitations;
}