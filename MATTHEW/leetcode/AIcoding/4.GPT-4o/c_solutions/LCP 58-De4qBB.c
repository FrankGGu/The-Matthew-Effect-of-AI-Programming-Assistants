int maxHeight(int** cuboids, int cuboidsSize, int* cuboidsColSize) {
    for (int i = 0; i < cuboidsSize; i++) {
        qsort(cuboids[i], 3, sizeof(int), cmp);
    }
    qsort(cuboids, cuboidsSize, sizeof(int*), cmpCuboids);

    int* dp = (int*)malloc(cuboidsSize * sizeof(int));
    for (int i = 0; i < cuboidsSize; i++) {
        dp[i] = cuboids[i][2];
    }

    for (int i = 0; i < cuboidsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1]) {
                dp[i] = fmax(dp[i], dp[j] + cuboids[i][2]);
            }
        }
    }

    int maxHeight = 0;
    for (int i = 0; i < cuboidsSize; i++) {
        maxHeight = fmax(maxHeight, dp[i]);
    }

    free(dp);
    return maxHeight;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int cmpCuboids(const void* a, const void* b) {
    return (*(int**)a)[0] - (*(int**)b)[0];
}