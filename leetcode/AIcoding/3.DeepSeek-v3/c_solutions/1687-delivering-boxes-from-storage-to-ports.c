long long boxDelivering(int** boxes, int boxesSize, int* boxesColSize, int portsCount, int maxBoxes, int maxWeight) {
    int n = boxesSize;
    int* diff = (int*)malloc((n + 1) * sizeof(int));
    long long* dp = (long long*)malloc((n + 1) * sizeof(long long));
    int* prefix_weight = (int*)malloc((n + 1) * sizeof(int));

    diff[0] = 0;
    prefix_weight[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix_weight[i + 1] = prefix_weight[i] + boxes[i][1];
        if (i == 0) {
            diff[i + 1] = 1;
        } else {
            diff[i + 1] = diff[i] + (boxes[i][0] != boxes[i - 1][0] ? 1 : 0);
        }
    }

    dp[0] = 0;
    int* dq = (int*)malloc((n + 1) * sizeof(int));
    int front = 0, rear = 0;
    dq[rear++] = 0;

    for (int i = 1; i <= n; i++) {
        while (front < rear && (i - dq[front] > maxBoxes || prefix_weight[i] - prefix_weight[dq[front]] > maxWeight)) {
            front++;
        }

        int j = dq[front];
        dp[i] = dp[j] + diff[i] - diff[j + 1] + 2;

        if (i < n) {
            while (front < rear && dp[i] - diff[i + 1] <= dp[dq[rear - 1]] - diff[dq[rear - 1] + 1]) {
                rear--;
            }
            dq[rear++] = i;
        }
    }

    long long result = dp[n];
    free(diff);
    free(dp);
    free(prefix_weight);
    free(dq);
    return result;
}