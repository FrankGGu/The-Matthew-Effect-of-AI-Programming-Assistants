long long distributeCandies(int n, int limit) {
    long long count = 0;
    for (int i = 0; i <= limit; i++) {
        int remaining = n - i;
        if (remaining < 0) break;
        if (remaining > 2 * limit) continue;

        int min_j = (remaining - limit > 0) ? remaining - limit : 0;
        int max_j = (remaining < limit) ? remaining : limit;

        if (min_j <= max_j) {
            count += (max_j - min_j + 1);
        }
    }
    return count;
}