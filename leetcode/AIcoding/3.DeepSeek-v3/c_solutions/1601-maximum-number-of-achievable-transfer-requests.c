int maximumRequests(int n, int** requests, int requestsSize, int* requestsColSize) {
    int max = 0;
    int m = requestsSize;

    for (int mask = 0; mask < (1 << m); mask++) {
        int count = __builtin_popcount(mask);
        if (count <= max) continue;

        int balance[n];
        for (int i = 0; i < n; i++) balance[i] = 0;

        for (int i = 0; i < m; i++) {
            if (mask & (1 << i)) {
                balance[requests[i][0]]--;
                balance[requests[i][1]]++;
            }
        }

        int valid = 1;
        for (int i = 0; i < n; i++) {
            if (balance[i] != 0) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            max = count;
        }
    }

    return max;
}