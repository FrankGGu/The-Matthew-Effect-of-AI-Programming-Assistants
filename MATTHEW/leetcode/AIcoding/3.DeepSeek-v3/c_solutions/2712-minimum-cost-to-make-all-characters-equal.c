long long minimumCost(char* s) {
    long long cost = 0;
    int n = strlen(s);

    for (int i = 1; i < n; i++) {
        if (s[i] != s[i-1]) {
            cost += (long long)fmin(i, n - i);
        }
    }

    return cost;
}