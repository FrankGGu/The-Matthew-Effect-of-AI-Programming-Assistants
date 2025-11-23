int findKthNumber(int n, int k) {
    long long current = 1;
    k--; 

    while (k > 0) {
        long long count = 0;
        long long low = current;
        long long high = current + 1;

        while (low <= n) {
            count += (high < n + 1 ? high : n + 1) - low;
            low *= 10;
            high *= 10;
        }

        if (k >= count) {
            current++;
            k -= count;
        } else {
            current *= 10;
            k--;
        }
    }

    return (int)current;
}