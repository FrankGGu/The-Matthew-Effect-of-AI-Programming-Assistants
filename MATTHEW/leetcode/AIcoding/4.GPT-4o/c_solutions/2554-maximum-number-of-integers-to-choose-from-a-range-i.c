int maxCount(int banned[], int n, int maxSum) {
    int count = 0;
    int sum = 0;
    int i = 1;
    int bannedSet[100001] = {0};

    for (int j = 0; j < n; j++) {
        bannedSet[banned[j]] = 1;
    }

    while (sum + i <= maxSum) {
        if (!bannedSet[i]) {
            sum += i;
            count++;
        }
        i++;
    }

    return count;
}