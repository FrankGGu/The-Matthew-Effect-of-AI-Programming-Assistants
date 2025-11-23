int* getTriggerTime(int** increase, int increaseSize, int* increaseColSize, int** requirements, int requirementsSize, int* requirementsColSize, int* returnSize) {
    int n = increaseSize;
    int m = requirementsSize;
    *returnSize = m;
    int* res = (int*)malloc(m * sizeof(int));

    int** prefix = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        prefix[i] = (int*)malloc(3 * sizeof(int));
    }

    prefix[0][0] = 0;
    prefix[0][1] = 0;
    prefix[0][2] = 0;

    for (int i = 1; i <= n; i++) {
        prefix[i][0] = prefix[i-1][0] + increase[i-1][0];
        prefix[i][1] = prefix[i-1][1] + increase[i-1][1];
        prefix[i][2] = prefix[i-1][2] + increase[i-1][2];
    }

    for (int i = 0; i < m; i++) {
        int c = requirements[i][0];
        int r = requirements[i][1];
        int h = requirements[i][2];

        if (c == 0 && r == 0 && h == 0) {
            res[i] = 0;
            continue;
        }

        int left = 0, right = n;
        int ans = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (prefix[mid][0] >= c && prefix[mid][1] >= r && prefix[mid][2] >= h) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        res[i] = ans;
    }

    for (int i = 0; i <= n; i++) {
        free(prefix[i]);
    }
    free(prefix);

    return res;
}