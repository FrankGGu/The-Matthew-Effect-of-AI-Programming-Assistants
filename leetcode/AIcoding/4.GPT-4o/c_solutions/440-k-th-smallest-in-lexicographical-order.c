int findKthNumber(int n, int k) {
    int current = 1;
    k--;

    while (k > 0) {
        int steps = 0;
        long long first = current;
        long long last = current + 1;

        while (first <= n) {
            steps += (long long) (last <= n ? last - first : n + 1 - first);
            first *= 10;
            last *= 10;
        }

        if (steps <= k) {
            current++;
            k -= steps;
        } else {
            current *= 10;
            k--;
        }
    }

    return current;
}