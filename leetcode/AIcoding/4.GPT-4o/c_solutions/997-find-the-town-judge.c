int findJudge(int n, int** trust, int trustSize, int* trustColSize) {
    int* trustCount = (int*)calloc(n + 1, sizeof(int));

    for (int i = 0; i < trustSize; i++) {
        trustCount[trust[i][1]]++;
        trustCount[trust[i][0]]--;
    }

    for (int i = 1; i <= n; i++) {
        if (trustCount[i] == n - 1) {
            free(trustCount);
            return i;
        }
    }

    free(trustCount);
    return -1;
}