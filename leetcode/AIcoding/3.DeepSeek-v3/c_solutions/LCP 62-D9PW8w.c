int transportationHub(int** path, int pathSize, int* pathColSize) {
    int maxNode = 0;
    for (int i = 0; i < pathSize; i++) {
        if (path[i][0] > maxNode) maxNode = path[i][0];
        if (path[i][1] > maxNode) maxNode = path[i][1];
    }
    maxNode++;

    int* inDegree = (int*)calloc(maxNode, sizeof(int));
    int* outDegree = (int*)calloc(maxNode, sizeof(int));
    int* exists = (int*)calloc(maxNode, sizeof(int));

    for (int i = 0; i < pathSize; i++) {
        int from = path[i][0];
        int to = path[i][1];
        outDegree[from]++;
        inDegree[to]++;
        exists[from] = 1;
        exists[to] = 1;
    }

    int totalNodes = 0;
    for (int i = 0; i < maxNode; i++) {
        if (exists[i]) totalNodes++;
    }

    for (int i = 0; i < maxNode; i++) {
        if (exists[i] && inDegree[i] == totalNodes - 1 && outDegree[i] == 0) {
            free(inDegree);
            free(outDegree);
            free(exists);
            return i;
        }
    }

    free(inDegree);
    free(outDegree);
    free(exists);
    return -1;
}