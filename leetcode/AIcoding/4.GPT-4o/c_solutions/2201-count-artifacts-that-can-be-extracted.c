int countArtifacts(int n, int** artifacts, int artifactsSize, int* artifactsColSize) {
    int count = 0;
    int *visited = (int *)calloc(n, sizeof(int));

    for (int i = 0; i < artifactsSize; i++) {
        int start = artifacts[i][0];
        int end = artifacts[i][1];
        int canExtract = 1;

        for (int j = start; j <= end; j++) {
            if (visited[j]) {
                canExtract = 0;
                break;
            }
        }

        if (canExtract) {
            count++;
            for (int j = start; j <= end; j++) {
                visited[j] = 1;
            }
        }
    }

    free(visited);
    return count;
}