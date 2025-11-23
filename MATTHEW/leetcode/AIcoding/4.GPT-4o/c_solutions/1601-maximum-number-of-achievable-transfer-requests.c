int maximumRequests(int n, int** requests, int requestsSize, int* requestsColSize) {
    int maxAchievable = 0;
    int totalStates = 1 << requestsSize;

    for (int state = 0; state < totalStates; state++) {
        int balance[n];
        memset(balance, 0, sizeof(balance));
        int count = 0;

        for (int i = 0; i < requestsSize; i++) {
            if (state & (1 << i)) {
                balance[requests[i][0]]++;
                balance[requests[i][1]]--;
                count++;
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
            maxAchievable = fmax(maxAchievable, count);
        }
    }

    return maxAchievable;
}