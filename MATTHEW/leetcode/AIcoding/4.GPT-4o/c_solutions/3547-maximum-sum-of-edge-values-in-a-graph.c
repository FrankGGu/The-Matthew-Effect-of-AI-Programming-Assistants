int maximumSum(int** edges, int edgesSize, int* edgesColSize) {
    int n = edgesSize + 1;
    int* degree = (int*)calloc(n, sizeof(int));
    int* sum = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
        sum[edges[i][0]] += edges[i][1];
        sum[edges[i][1]] += edges[i][0];
    }

    int maxSum = 0;

    for (int i = 0; i < n; i++) {
        if (degree[i] > 0) {
            for (int j = i + 1; j < n; j++) {
                if (degree[j] > 0) {
                    int currentSum = sum[i] + sum[j] - (i + j);
                    if (currentSum > maxSum) {
                        maxSum = currentSum;
                    }
                }
            }
        }
    }

    free(degree);
    free(sum);

    return maxSum;
}