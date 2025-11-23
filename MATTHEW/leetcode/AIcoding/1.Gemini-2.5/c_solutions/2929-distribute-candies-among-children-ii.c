long long combinations2(int val) {
    if (val < 2) {
        return 0;
    }
    return (long long)val * (val - 1) / 2;
}

long long distributeCandies(int n, int limit) {
    long long total = combinations2(n + 2);

    long long term1 = combinations2(n - limit + 1);

    long long term2 = combinations2(n - 2 * limit);

    long long term3 = combinations2(n - 3 * limit - 1);

    long long result = total - 3 * term1 + 3 * term2 - term3;

    return result;
}