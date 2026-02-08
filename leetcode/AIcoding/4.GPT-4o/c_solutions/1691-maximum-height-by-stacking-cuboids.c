int maxHeight(int** cuboids, int cuboidsSize, int* cuboidsColSize) {
    int n = cuboidsSize;
    int dp[100]; 
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < 3; j++) {
            for (int k = j + 1; k < 3; k++) {
                if (cuboids[i][j] > cuboids[i][k]) {
                    int temp = cuboids[i][j];
                    cuboids[i][j] = cuboids[i][k];
                    cuboids[i][k] = temp;
                }
            }
        }
    }
    qsort(cuboids, n, sizeof(int*) * 3, cmp);
    for (int i = 0; i < n; i++) {
        dp[i] = cuboids[i][2];
    }
    int maxHeight = dp[0];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (cuboids[i][0] >= cuboids[j][0] && cuboids[i][1] >= cuboids[j][1]) {
                dp[i] = fmax(dp[i], dp[j] + cuboids[i][2]);
            }
        }
        maxHeight = fmax(maxHeight, dp[i]);
    }
    return maxHeight;
}

int cmp(const void *a, const void *b) {
    int *cuboid1 = *(int **)a;
    int *cuboid2 = *(int **)b;
    if (cuboid1[0] == cuboid2[0]) {
        return cuboid1[1] - cuboid2[1];
    }
    return cuboid1[0] - cuboid2[0];
}