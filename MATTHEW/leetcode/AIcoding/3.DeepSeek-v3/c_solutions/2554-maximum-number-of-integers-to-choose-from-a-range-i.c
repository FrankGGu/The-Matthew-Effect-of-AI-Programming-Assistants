int maxCount(int* banned, int bannedSize, int n, int maxSum) {
    int bannedSet[10001] = {0};
    for (int i = 0; i < bannedSize; i++) {
        if (banned[i] <= 10000) {
            bannedSet[banned[i]] = 1;
        }
    }

    int count = 0;
    int sum = 0;
    for (int i = 1; i <= n; i++) {
        if (bannedSet[i]) continue;
        if (sum + i > maxSum) break;
        sum += i;
        count++;
    }
    return count;
}