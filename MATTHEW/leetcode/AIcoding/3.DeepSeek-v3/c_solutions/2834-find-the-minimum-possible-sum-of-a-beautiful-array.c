int minimumPossibleSum(int n, int target) {
    long long m = target / 2;
    if (n <= m) {
        return (long long)n * (n + 1) / 2;
    }
    return (m * (m + 1) / 2) + ((long long)target + target + n - m - 1) * (n - m) / 2;
}